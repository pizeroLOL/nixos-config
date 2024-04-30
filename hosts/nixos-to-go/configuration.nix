# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../de/hyprland.nix
    ../../de/plasma.nix
    ../../de/fonts.nix
  ];

  # 允许非自由软件
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    # 镜像站
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.cernet.edu.cn/nix-channels/store"
    ];
    # 实验性功能
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # 引导
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  boot.plymouth = {
    enable = true;
    # extraConfig = with pkgs; [ kdePackages.breeze-plymouth ];
    theme = "breeze";
  };

  # 网络
  networking = {
    hostName = "nixos-to-go"; # Define your hostname.
    networkmanager.enable = true;
    # 代理
    # proxy.default = "http://127.0.0.1:20171";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # 时间
  time.timeZone = "Asia/Shanghai";

  services.displayManager.sddm.enable = true;

  # 用户，别忘了设置密码
  users.users.pizero = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # 系统软件包
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    btrfs-progs
    git
    polkit
    polkit_gnome
    adwaita-qt
    adwaita-qt6
    libsForQt5.qt5ct
    trash-cli
    flatpak
    gnome.gnome-software

    # MC，hm 管不好默认 jdk
    temurin-bin-21
    # temurin-bin-11
    temurin-bin-8
  ];

  services.flatpak.enable = true;

  # 设置默认编辑器
  environment.variables.EDITOR = "nvim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # 网络分析工具
  programs.mtr.enable = true;

  # 个人密钥
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # 系统默认 shell
  programs.zsh.enable = true;

  # List services that you want to enable:

  services.openssh.enable = true;

  # 防火墙
  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.firewall.allowedUDPPorts = [ 80 ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = false;

  # 立体机动装置
  # services.v2raya.enable = true;

  # 输入法
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-chinese-addons
    ];
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # offload = {
    #   enable = true;
    #   enableOffloadCmd = true;
    # };
  };

  specialisation = {
    at-home.configuration = {
      system.nixos.tags = [ "at-home" ];
      hardware.nvidia.prime = {
        sync.enable = lib.mkForce true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # 桌面前置-xserver
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb.layout = "us";
    xkb.options = "eurosign:e,caps:escape";
    videoDrivers = [
      "modesetting"
      "fbdev"
      "nvidia"
    ];
  };

  # 触摸板支持
  services.libinput.enable = true;

  # 打印机
  services.printing.enable = true;

  # 声音
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # 桌面
  programs.hyprland.enable = true;

  # polkit-gnome 用于让桌面应用获取 sudo 权限
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
