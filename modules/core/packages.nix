{
  pkgs,
  inputs,
  config,
  ...
}:
{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-33.4.11"
  ];
  programs = {
    xwayland.enable = true;
    virt-manager.enable = true;
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    thunar
    thunar-archive-plugin
    thunar-volman # For removable media support
    file-roller # Archive backend for thunar-archive-plugin

    amfora # Fancy Terminal Browser For Gemini Protocol
    pavucontrol # For Editing Audio Levels & Devices
    postgresql
    tuigreet

    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default

    protonup-qt

    wireshark

    input-leap

    devenv

    winetricks
    # clipse
    lutris
    eza
    rar
    zip
    unrar
    unzip
    neovim
    pciutils
    usbutils
    vlc
    wget

    unetbootin

    cliphist

    cups
    cups-filters
    system-config-printer

    tealdeer

    opencode
    code-cursor

    gsettings-desktop-schemas
    glib

    libx11
    libxrender
    libxtst
    libxi
    libxcb

    remmina

    libGL

    # inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.yazi # TUI FileMgr

    gimp

    lsfg-vk
    lsfg-vk-ui

    prismlauncher
    mangohud

    #hypr tools
    hyprpicker
  ];
}
