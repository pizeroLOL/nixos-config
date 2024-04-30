# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:
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
    temurin-bin-21
    # temurin-bin-11
    temurin-bin-8
    adwaita-qt
    adwaita-qt6
    libsForQt5.qt5ct
    trash-cli
    flatpak
    gnome.gnome-software
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

  # 桌面前置-xserver
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb.layout = "us";
    xkb.options = "eurosign:e,caps:escape";
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
