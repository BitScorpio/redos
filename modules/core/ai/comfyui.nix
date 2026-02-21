{ config, pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.nix-comfyui.overlays.default ];
  
  environment.systemPackages = with pkgs; [
    comfyuiPackages.comfyui
  ];
}