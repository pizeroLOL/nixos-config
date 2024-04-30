{ config, lib, pkgs, ... }: {
  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji-blob-bin
    # source-han-sans
    # source-han-serif
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    sarasa-gothic  #更纱黑体
    source-code-pro
    hack-font
    jetbrains-mono
  ];

  # 简单配置一下 fontconfig 字体顺序，以免 fallback 到不想要的字体
  fonts.fontconfig.defaultFonts = {
    emoji = [ "Noto Color Emoji" ];
    monospace = [
      "FiraCode Nerd Font"
      "FiraCode"
      "JetBrains Mono"
      "Noto Sans Mono CJK SC"
      "Sarasa Mono SC"
      "DejaVu Sans Mono"
    ];
    sansSerif = [ "Noto Sans CJK SC" "Source Han Sans SC" "DejaVu Sans" ];
    serif = [ "Noto Serif CJK SC" "Source Han Serif SC" "DejaVu Serif" ];
  };
}
