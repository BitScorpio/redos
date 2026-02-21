{
  pkgs,
  config,
  lib,
  username,
  ...
}:
{
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };
  };

  boot = {
    initrd.kernelModules = lib.mkBefore [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "kvmfr"
    ];
    
    extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
  };


  boot.extraModprobeConfig = ''
    options kvmfr static_size_mb=32
  '';

  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", KERNEL=="kvmfr*", OWNER="${username}", GROUP="kvm", MODE="0660"
  '';

  environment.systemPackages = with pkgs; [
    looking-glass-client
    spice-vdagent
    virtiofsd
  ];

  virtualisation.libvirtd.qemu.verbatimConfig = ''
    cgroup_device_acl = [
      "/dev/null", "/dev/full", "/dev/zero",
      "/dev/random", "/dev/urandom",
      "/dev/ptmx", "/dev/kvm",
      "/dev/kvmfr0"
    ]
  '';

  systemd.tmpfiles.rules = [ "f /dev/shm/looking-glass 0660 ${username} qemu-libvertd -" ];
}
