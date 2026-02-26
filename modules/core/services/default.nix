{ ... }:
{
  imports = [
    ./audio.nix
    ./ssh.nix
    ./roon.nix
    ./mullvad.nix
    ./syncthing.nix
  ];

  services = {
    trezord.enable = true; # Trezor crypto wallet
    libinput.enable = true; # Input handling
    fstrim.enable = true; # SSD optimizer
    gvfs.enable = true; # Mounting USB & more
    blueman.enable = true; # Bluetooth support
    tumbler.enable = true; # Image/video preview
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    tailscale.enable = true;
    smartd = {
      enable = true; # cannot be enabled on a VM
      autodetect = true;
    };
  };
}
