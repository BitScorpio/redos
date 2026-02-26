{
  host,
  options,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix) hostname;
in
{
  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;
    enableIPv6 = false;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall.enable = false;
    firewall.checkReversePath = "loose";
  };

  services.resolved = {
    enable = true;
  };
}
