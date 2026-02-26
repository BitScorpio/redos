{
  pkgs,
  username,
  ...
}:
{
  home.packages = with pkgs; [
    swww
    grim
    swappy
    ydotool

    #media capture
    slurp
    wl-clipboard
    wf-recorder

    #notifications
    libnotify

    #mousekeys
    wlrctl

    #hypr tools
    hyprpicker
  ];
  systemd.user = {
    targets.hyprland-session.Unit.Wants = [
      "xdg-desktop-autostart.target"
    ];
    services = {
      waybar = {
        Unit = {
          Description = "Waybar status bar";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
          Wants = [ "graphical-session.target" ];
        };

        Service = {
          ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
          ExecStart = "${pkgs.waybar}/bin/waybar";
          Restart = "on-failure";
          RestartSec = "5";
        };

        Install = {
          WantedBy = [ "hyprland-session.target" ];
        };
      };
      xdg-desktop-portal-hyprland = {
        Service = {
          Restart = "on-failure";
          RestartSec = "5";
        };
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };
  # Place Files Inside Home Directory
  home.file."Pictures/Wallpapers" = {
    source = ../../../wallpapers;
    recursive = true;
  };
}
