{ config, pkgs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ];
    shell = pkgs.bash;
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    usb-modeswitch
    usbutils
    usb-modeswitch-data
    playerctl
  ];

  services.printing.enable = true;

  # TP-Link TX50UH (RTL8832CU) usb_modeswitch
  services.udev.packages = with pkgs; [ usb-modeswitch-data ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -v 0bda -p 1a2b -K"
  '';
}
