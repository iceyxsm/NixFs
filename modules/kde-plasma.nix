{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa kdepim-runtime kmahjongg kmines
    konversation kpat ksudoku ktorrent
  ];

  environment.systemPackages = with pkgs; [
    wayland-utils wl-clipboard
    kdePackages.breeze

    # Smart Video Wallpaper dependencies
    kdePackages.qtmultimedia
    kdePackages.extra-cmake-modules
    kdePackages.kpackage
    kdePackages.libplasma
  ];

  qt.enable = true;
  qt.platformTheme = "qt5ct";
}
