{
  username,
  host,
  config,
  ...
}:
let

  inherit (import ../../../hosts/${host}/variables.nix)
    mainMonitor
    wallpaper
    ;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
        unlock_cmd = "systemctl --user restart waybar";
      };
      background = [
        {
          path = "/home/${username}/Pictures/Wallpapers/${wallpaper}";
          blur_passes = 3;
          blur_size = 8;
          color = "rgb(${config.lib.stylix.colors.base02})";
        }
      ];
      line = [
        {
          color = "rgb(${config.lib.stylix.colors.base0D})";
          thickness = 4;
          position = "0, -35";
          length = 250;
          halign = "center";
          valign = "center";
        }
      ];
      label = [
        {
          text = "Welcome back, ${username}!";
          font_size = 50;
          font_family = "Noto Sans";
          color = "rgb(${config.lib.stylix.colors.base05})";
          position = "0, 160";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo $(date '+%A, %d %B %Y')";
          font_size = 30;
          font_family = "Noto Sans";
          color = "rgb(${config.lib.stylix.colors.base05})";
          position = "0, 110";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo $(date '+%I:%M:%S %p')";
          font_size = 30;
          font_family = "Noto Sans";
          color = "rgb(${config.lib.stylix.colors.base05})";
          position = "0, 65";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          size = "300, 50";
          position = "0, 0";
          monitor = mainMonitor;
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(${config.lib.stylix.colors.base05})";
          inner_color = "rgb(${config.lib.stylix.colors.base00})";
          outer_color = "rgb(${config.lib.stylix.colors.base0D})";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;

          # Additional settings
          check_color = "rgb(${config.lib.stylix.colors.base0B})"; # Success/green
          fail_color = "rgb(${config.lib.stylix.colors.base08})"; # Error/red
          capslock_color = "rgb(${config.lib.stylix.colors.base09})"; # Warning/yellow
          # numlock_color = "rgb(6F98E8)"; # Color when numlock is on
          fail_text = "Authentication failed!"; # Text on auth failure
          rounding = 10; # Corner rounding
          # shadow_color = "rgb(111111)"; # Shadow color
          font_family = "JetBrains Mono Nerd Font"; # Change the font
        }
      ];
    };
  };
}
