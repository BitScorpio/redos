{
  pkgs,
  host,
  options,
  ...
}:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    enableIPv6 = false;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = false;
    };
    # environment.systemPackages = with pkgs; [ networkmanagerapplet ];
    firewall.allowedTCPPorts = [
      21115
      21116
      21117
      21118
      21119
    ];
    firewall.allowedUDPPorts = [ 21116 ];
    firewall.checkReversePath = "loose";
  };

  services.resolved = {
    enable = true;
  };

}
