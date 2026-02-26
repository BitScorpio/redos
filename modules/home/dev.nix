{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nss
    nspr

    cmake
    ninja
    direnv
    nix-direnv

    gitui
    nixfmt

    jetbrains-toolbox

    cargo
    gcc

    gtk3

    gh
    docker_28
    maven

    ghidra

    nodejs_22

    python311
    python311Packages.requests
    python311Packages.rich
    python311Packages.pip
  ];
}
