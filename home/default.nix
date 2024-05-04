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

    # 代码编辑器
    vscode.fhs
    vscodium.fhs
    neovide
    neovim
    helix

    # nix
    nixd
    nixfmt-rfc-style
    nix-output-monitor

    # python
    python3

    # rust
    rustc
    cargo

    # cmd
    tree
    fzf
    eza

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
    virtualbox
    virt-manager
  ];
}
