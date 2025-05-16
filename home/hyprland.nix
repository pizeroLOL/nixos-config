{
  pkgs,
  ...
}:
{
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   settings = {

  #   };
  # };
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    # package =
    size = 16;
  };

  gtk = {
    enable = true;
    # theme = {
    #   package = pkgs.kdePackages.breeze-gtk;
    #   name = "Breeze";
    # };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Noto Sans CJK SC";
      size = 16;
    };
  };

  qt = {
    enable = true;
    style = "adwaita";
    platformTheme = "qt5ct";
  };
}
