{ config, lib, pkgs, ... }: {
  services.desktopManager.plasma6.enable = true;
  programs.dconf.enable = true;
}