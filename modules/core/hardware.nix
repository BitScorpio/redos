{
  pkgs,
  config,
  local,
  ...
}:
{
  hardware = {
    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
      disabledDefaultBackends = [ "escl" ];
    };
    graphics.enable = true;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    xpadneo.enable = true;
    xone.enable = true;
  };

  # MAINTENANCE: Kernel compatibility patches for xpad-noone, xpadneo, and v4l2loopback.
  # These work around API changes in Linux 6.18 (ida_simple_get -> ida_alloc).
  # Check if still needed after kernel or upstream package updates.
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_latest = prev.linuxPackages_latest.extend (
        lpFinal: lpPrev: {
          xpad-noone = lpPrev.xpad-noone.overrideAttrs (old: {
            postPatch = (old.postPatch or "") + ''
              sed -i 's/ida_simple_get(&xpad_pad_seq, 0, 0,/ida_alloc(\&xpad_pad_seq,/' xpad.c
              sed -i 's/ida_simple_remove/ida_free/g' xpad.c
            '';
          });
          xpadneo = lpPrev.xpadneo.overrideAttrs (old: {
            postPatch = (old.postPatch or "") + ''
              sed -i 's/ida_simple_get(&xpadneo_device_id_allocator, 0, 0,/ida_alloc(\&xpadneo_device_id_allocator,/' hid-xpadneo.c
              sed -i 's/ida_simple_remove/ida_free/g' hid-xpadneo.c
            '';
          });
          v4l2loopback = lpPrev.v4l2loopback.overrideAttrs (old: {
            version = "unstable-2024-12-01";
            src = final.fetchFromGitHub {
              owner = "v4l2loopback";
              repo = "v4l2loopback";
              rev = "main"; # or a specific commit
              sha256 = "sha256-KXJgsEJJTr4TG4Ww5HlF42v2F1J+AsHwrllUP1n/7g8=";
            };
          });
        }
      );
    })
  ];
}
