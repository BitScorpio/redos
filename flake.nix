{
  description = "RedOs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    agenix.url = "github:ryantm/agenix";
    
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nvf.url = "github:notashelf/nvf";
    
    nix-comfyui.url = "github:dyscorv/nix-comfyui";
  };
  
  outputs = {
    nixpkgs,
    nix-comfyui,
    home-manager,
    agenix,
    zen-browser,
    ...
  }@inputs:
  let
    system = "x86_64-linux";
    host = "default";
    profile = "nvidia";
    username = "red";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        nix-comfyui.overlays.default
        (final: prev: {
          digital = final.callPackage ./pkgs/digital.nix { };
        })
      ];
    };
  in
  {
    nixosConfigurations.nvidia = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        inherit username;
        inherit host;
        inherit profile;
      };
      modules = [
        {
          nixpkgs.config.allowUnfree = true;
        }
        agenix.nixosModules.default
        ./profiles/nvidia
      ];
    };
  };
}