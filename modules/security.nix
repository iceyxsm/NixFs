{ config, pkgs, ... }:

{
  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  # Fail2ban
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "24h";
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h";
      overalljails = true;
    };
  };

  # Earlyoom - OOM killer
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    freeSwapThreshold = 5;
  };

  # DNS over TLS via systemd-resolved
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#cloudflare-dns.com" "9.9.9.9#dns.quad9.net" ];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };

  # Journal size cap
  services.journald.extraConfig = "SystemMaxUse=100M";
}
