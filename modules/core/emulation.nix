{ pkgs, inputs, config, ... }:
{
  # Install emulation packages
  environment.systemPackages = with pkgs; [
    # RetroArch with cores for older systems
    retroarch-free
    ryubing

    # GameCube/Wii emulation
    dolphin-emu
    shadps4
  ];
}
