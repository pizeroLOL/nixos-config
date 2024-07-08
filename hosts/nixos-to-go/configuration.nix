# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./video.nix
    ./language.nix
    ./nix.nix
    ../../de/cosmic.nix
    ../../de/hyprland.nix
    ../../de/plasma.nix
    ../../de/fonts.nix
  ];

  system.stateVersion = "23.11"; # Did you read the comment?

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

  boot.kernelParams = [ "i915.enable_guc=2" ];
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

  # services.auto-cpufreq.enable = true;
  # services.auto-cpufreq.settings = {
  #   battery = {
  #     governor = "performance";
  #     turbo = "auto";
  #   };
  #   charger = {
  #     governor = "performance";
  #     turbo = "auto";
  #   };
  # };
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };
  services.power-profiles-daemon.enable = false;
  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };

  # 网络
  networking = {
    hostName = "nixos-to-go"; # Define your hostname.
    networkmanager.enable = true;
    # 代理
    # proxy.default = "http://127.0.0.1:20171";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  hardware.bluetooth = {
    powerOnBoot = true;
    enable = true;
  };
  services.blueman.enable = true;

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

  services.displayManager.autoLogin.user = "pizero";

  # 系统软件包
  environment.systemPackages =
    (with pkgs; [
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
      rustdesk

      # MC，hm 管不好默认 jdk
      zulu
      # temurin-bin-11
      zulu8

      # wine
      winetricks
      wineWowPackages.staging
      vkd3d
      dxvk
      samba
      gnutls
      gst
      libkrb5

      lm_sensors
    ])
    ++ import ../../tools/compress.nix { inherit pkgs; };
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

  # direnv
  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    direnvrcExtra = "";
    nix-direnv.enable = true;
  };

  # 支持鬼才应用
  programs.nix-ld.enable = true;
  programs.appimage.enable = true;

  # TODO: 中文字体无法使用
  programs.steam = {
    enable = true;
    # extest.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

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
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
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
  #hardware.pulseaudio = {
  #  enable = true;
  #  package = pkgs.pulseaudioFull;
  #};
}
