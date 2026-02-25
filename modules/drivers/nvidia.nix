{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.drivers.nvidia;
in
{
  options.drivers.nvidia = {
    enable = mkEnableOption "Enable Nvidia Drivers";
  };
  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    boot.initrd.kernelModules = lib.mkAfter [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
      "uinput"
    ];

    boot.kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia-drm.modeset=1"
    ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          vulkan-validation-layers
          nvidia-vaapi-driver
        ];
      };

      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;

        package = pkgs.linuxPackages.nvidiaPackages.beta;
        powerManagement.enable = true;
        open = true;
      };
    };

    console = {
      earlySetup = true;
      keyMap = "us";
    };
  };
}
