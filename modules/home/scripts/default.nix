{
  pkgs,
  username,
  ...
}:
{
  home.packages = [
    (import ./rofi-launcher.nix { inherit pkgs; })
    (import ./squirtle.nix { inherit pkgs; })
    (import ./keybinds.nix { inherit pkgs; })
    (import ./wallsetter.nix { inherit pkgs; })
    (import ./screen-capture.nix { inherit pkgs; })
    (import ./screen-record.nix { inherit pkgs; })
    (import ./check-mullvad.nix { inherit pkgs; })
    (import ./task-waybar.nix { inherit pkgs; })
    (import ./recording-status.nix { inherit pkgs; })
    (import ./autoclicker.nix { inherit pkgs; })
    (import ./waybar-gpu-usage.nix { inherit pkgs; })
    (import ./waybar-gpu-mem.nix { inherit pkgs; })
  ];
}
