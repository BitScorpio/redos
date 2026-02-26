{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    heroic
    runelite

    gamescope
    mangohud

    # vulkan
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
    mesa
    wayland
    wayland-protocols
    libdecor

    libxkbcommon
    libx11
    libxcursor
    libxrandr
  ];
}
