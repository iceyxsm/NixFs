{ config, pkgs, hostname, ... }:

{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
  };

  services.openssh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
