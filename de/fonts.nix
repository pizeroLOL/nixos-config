{ pkgs, ... }:
{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji-blob-bin
    # source-han-sans
    # source-han-serif
    # fira-code-nerdfont
    # (nerdfonts.override { fonts = [ "FiraCode" ]; })
    nerd-fonts.fira-code
    sarasa-gothic # 更纱黑体
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
    ];
    sansSerif = [
      "Noto Sans CJK SC"
      # "Source Han Sans SC"
    ];
    serif = [
      "Noto Serif CJK SC"
      # "Source Han Serif SC"
    ];
  };
}
