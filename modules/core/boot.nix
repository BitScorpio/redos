{
  pkgs,
  lib,
  config,
  host,
  ...
}:
{
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = lib.mkAfter [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    kernelParams = [
      "quiet"
      "splash"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    #graphical boot screen
    plymouth.enable = true;

    supportedFilesystems = [
      "ntfs"
      "lvm2"
    ];
    loader = {
      grub = {
        enable = true;
        # device = "/dev/disk/by-id/nvme-Samsung_SSD_990_PRO_2TB_S7L9NJ0Y421875V";
        device = "nodev";
        efiSupport = true;
        useOSProber = true;

        theme =
          let
            falloutTheme = pkgs.fetchFromGitHub {
              owner = "shvchk";
              repo = "fallout-grub-theme";
              rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
              sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
            };
          in
          lib.mkForce "${falloutTheme}";

        # Set console resolution
        gfxmodeEfi = "1920x1080";

        #legacy bios
        # gfxmodeBios = "1920x1080";

        extraEntries = ''
          menuentry "Reboot" {
            reboot
          }
          menuentry "Shutdown" {
            halt
          }
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root 262B-2D35
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };
}
