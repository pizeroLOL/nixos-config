{ pkgs, ... }:
{
  # 语言与输入法
  i18n = {
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    defaultLocale = "zh_CN.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "zh_CN.UTF-8";
      LC_ALL = "zh_CN.UTF-8";
    };
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-chinese-addons
      ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # 时间
  time.timeZone = "Asia/Shanghai";
}
