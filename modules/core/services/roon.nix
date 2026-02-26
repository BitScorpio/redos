{ ... }:
{
  services.roon-server = {
    enable = true;
    openFirewall = true;
  };
  services.roon-bridge = {
    enable = true;
    openFirewall = true;
  };
}
