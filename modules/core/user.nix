{
  username,
  pkgs,
  host,
  profile,
  inputs,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {
      inherit
        inputs
        username
        host
        profile
        ;
    };
    users.${username} = {
      gtk = {
        enable = true;
      };
      imports = [ ./../home ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "25.11";
      };
      programs.home-manager.enable = true;
    };
  };
  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "wireshark"
      "docker"
      "libvirtd"
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
      "ydotool"
      "input"
      "kvm"
    ];

    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [ "${username}" ];
  nix.settings.trusted-users = [
    "${username}"
    "root"
  ];
}
