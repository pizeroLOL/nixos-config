{ config, pkgs, ... }: {
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

    # 代码编辑器
    vscode.fhs
    vscodium.fhs
    neovide
    neovim
    helix

    # nix 开发全家桶
    nixd
    nixfmt-rfc-style
    nix-output-monitor

    # 整活
    rustc
    cargo

    # 摸鱼工具
    tree
    fzf
    eza
    python3

    # 游戏
    hmcl
    steam

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

    # 性能监看
    btop
    htop
    iotop # io monitoring
    iftop # network monitoring

    # 终端
    alacritty

    # 桌面
    rofi-wayland
    waybar
    grim
    hyprpaper
    libsForQt5.kdeconnect-kde
    flatpak
  ];
  imports = [ ./hyprland.nix ];



}
