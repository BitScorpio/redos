{ inputs, ... }:
{
  imports = [
    ./virtualisation
    ./packages.nix
    ./boot.nix
    ./discord.nix # maybe move to home
    ./system.nix
    ./hardware.nix
    ./greetd.nix
    ./starfish.nix
    ./services
    ./networking.nix
    ./arr-proxy.nix
    ./user.nix
    ./printing.nix
    ./postgresql.nix
    ./stylix.nix
    ./steam.nix
    ./fonts.nix
    ./xdg.nix
    ./emulation.nix
    ./tailscale.nix

    ./ai
    inputs.stylix.nixosModules.stylix
  ];

  # Xfce on X11 for TTY-based X11 apps that don't run on Wayland
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    desktopManager.xfce.enable = true;
    screenSection = ''
      Option "metamodes" "DFP-1: nvidia-auto-select +0+0, DFP-1: nvidia-auto-select +3840+0"
    '';

  };

  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;
}
