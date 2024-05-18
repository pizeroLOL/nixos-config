# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./video.nix
    ./language.nix
    ../../de/hyprland.nix
    ../../de/plasma.nix
    ../../de/fonts.nix
    ../../nix.nix
  ];

  specialisation.at-home.configuration = {
    system.nixos.tags = [ "at-home" ];
    nix.settings.system-features = [
      "nixos-test"
      "benchmark"
      "big-parallel"
      "kvm"
      "gccarch-skylake"
      "gcctune-skylake"
    ];
  };

  boot.supportedFilesystems = [ "ntfs" ];

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

  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    autoNumlock = true;
  };

  # 用户，别忘了设置密码
  users.users.pizero = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # 系统软件包
  environment.systemPackages = (
    with pkgs;
    [
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
      zulu
      # temurin-bin-11
      zulu8

      # wine
      winetricks
      wineWowPackages.staging
    ]
  );
  # ++ [
  #   # 聊天
  #   config.nur.repos.xddxdd.wechat-uos

  #   # 桌面
  #   config.nur.repos.baduhai.koi
  # ];

  services.flatpak.enable = true;

  # 设置默认环境变量
  environment.variables = {
    EDITOR = "nvim";

    # 给 JAVA 擦屁股
    JAVA8_HOME = "${pkgs.zulu8}";
    JAVA21_HOME = "${pkgs.zulu}";
    JAVA_HOME = "${pkgs.zulu}";
  };

  # 个人密钥
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # 系统默认 shell
  programs.zsh.enable = true;

  # 支持鬼才应用
  programs.nix-ld.enable = true;
  programs.appimage.enable = true;

  # 张小龙的马
  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];

  # ssh
  services.openssh = {
    enable = true;
    ports = [ 20022 ];
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    waydroid.enable = true;
    virtualbox = {
      host.enable = true;
      host.enableExtensionPack = true;
    };
  };

  users.extraGroups.vboxusers.members = [ "pizero" ];

  # 防火墙
  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.firewall.allowedUDPPorts = [ 80 ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = false;

  # 立体机动装置
  services.v2raya.enable = true;

  # 触摸板支持
  services.libinput.enable = true;

  # 打印机
  services.printing.enable = true;

  # 声音
  sound.enable = true;
  hardware.pulseaudio.enable = true;

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
