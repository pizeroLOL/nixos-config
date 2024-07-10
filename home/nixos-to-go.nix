{
  # config,
  # nur,
  pkgs,
  ...
}:
{
  imports = [ ./settings/helix.nix ];

  programs.home-manager.enable = true;
  home.username = "pizero";
  home.homeDirectory = "/home/pizero";
  home.stateVersion = "24.05";
  home.packages =
    (with pkgs; [
      # 浏览器
      firefox-bin
      chromium

      # 聊天
      qq
      wechat-uos
      fluffychat
      thunderbird-bin-unwrapped

      feishu

      # 文档
      libreoffice-fresh

      # 图片
      gimp-with-plugins

      # OCR
      gImageReader

      # 建模
      # FIX: https://github.com/NixOS/nixpkgs/pull/326044
      # blender

      # 游戏
      hmcl

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

      # 安卓
      android-tools

      # cmd
      tree
      fzf
      eza
      bat
      zellij # 终端复用器

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
    ])
    ++ import ./dev/nix.nix { inherit pkgs; }
    ++ import ./dev/python.nix { inherit pkgs; }
    ++ import ./dev/kotlin.nix { inherit pkgs; }
    ++ import ./dev/rust.nix { inherit pkgs; }
    ++ import ./dev/frontend.nix { inherit pkgs; };
}
