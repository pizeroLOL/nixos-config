{ pkgs, ... }:
{
  # 桌面
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

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

  # qt = {
  #   enable = true;
  #   # platformTheme = "qt5ct";
  #   style = "breeze";
  # };
}
