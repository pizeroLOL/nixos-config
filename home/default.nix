{
  # config,
  # nur,
  pkgs,
  ...
}:
{
  # imports = [ nur.hmModules.nur ];

  programs.home-manager.enable = true;
  home.username = "pizero";
  home.homeDirectory = "/home/pizero";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    # 浏览器
    firefox-bin
    chromium

    # 聊天
    qq
    fluffychat
    feishu

    # 文档
    libreoffice-fresh

    # 图片
    gimp-with-plugins

    # OCR
    gImageReader

    # 建模
    blender

    # 游戏
    hmcl
    steam

    # 性能监看
    btop
    htop
    iotop # io monitoring
    iftop # network monitoring
    nvitop

    # 桌面
    rofi-wayland
    waybar
    grim
    hyprpaper
    libsForQt5.kdeconnect-kde
    flatpak

    # 终端
    kdePackages.yakuake
    alacritty
    android-tools

    # 代码编辑器
    vscode.fhs
    vscodium.fhs
    neovim
    helix
    zed-editor
    jetbrains.idea-community
    android-studio

    # nix
    nixd
    nixfmt-rfc-style
    nix-output-monitor

    # python
    python3

    # kotlin
    kotlin
    kotlin-language-server
    gradle

    # 安卓
    android-tools

    # rust
    rustc
    cargo

    # cmd
    tree
    fzf
    eza
    bat
    zellij # 终端复用器

    # 压缩工具
    zstd
    zip
    xz
    unzip
    p7zip

    # 网络工具
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # 视频工具
    ffmpeg
    vlc
    obs-studio
    kdePackages.kdenlive

    # 虚拟机
    virt-manager
  ];
}
