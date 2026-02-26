{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cups
    cups-filters
    system-config-printer
  ];

  services.printing = {
    enable = true;
    startWhenNeeded = true;
    browsing = true;
    defaultShared = false;
    listenAddresses = [ "127.0.0.1:631" ]; # IPv4 only
    drivers = [
      pkgs.gutenprint
      pkgs.cnijfilter2
    ];
    extraConf = ''
      DefaultEncryption Never
    '';
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    ipv6 = false; # Disable IPv6 for Avahi too
  };

  hardware.sane.enable = true;

  # Explicitly enable firewall for CUPS
  networking.firewall.allowedTCPPorts = [ 631 ];
}
