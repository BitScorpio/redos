{
  host,
  username,
  config,
  ...
}:
let

  inherit (import ../../../hosts/${host}/variables.nix)
    extraMonitorSettings
    keyboardLayout
    wallpaper
    ;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "killall -q swww;sleep .5"
        "swww-daemon &"
        "killall -q swaync;sleep .5 && swaync"
        "nm-applet --indicator" 
        "lxqt-policykit-agent"
        "pypr &"
        "sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/${wallpaper}"

        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "ydotoold &"
        "hyprctl setcursor Bibata-Modern-Classic 24"
      ];

      render = {
        cm_fs_passthrough = 2;
        cm_auto_hdr = 2;
        direct_scanout = 1;
      };

      input = {
        kb_layout = "${keyboardLayout}";
        numlock_by_default = true;
        repeat_delay = 300;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          scroll_factor = 0.8;
        };
      };

      general = {
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
        "col.active_border" =
          "rgb(${config.lib.stylix.colors.base08}) rgb(${config.lib.stylix.colors.base0C}) 45deg";
        "col.inactive_border" = "rgb(${config.lib.stylix.colors.base01})";
      };

      misc = {
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      cursor = {
        sync_gsettings_theme = true;
        enable_hyprcursor = false;
        warp_on_change_workspace = 2;
        no_warps = true;
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };
      windowrule = [
        "move 72% 7%, match:title ^(Picture-in-Picture)$"
        "center on, match:class ^([Ff]erdium)$"
        "center on, match:class ^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "center on, match:class ^([Tt]hunar)$, match:title negative:(.*[Tt]hunar.*)"
        "center on, match:title ^(Authentication Required)$"
        # "idleinhibit fullscreen, match:class ^(.*)$"
        # "idleinhibit fullscreen, match:title ^(.*)$"
        # "idleinhibit fullscreen, match:fullscreen 1"
        "float on, match:class ^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$"
        "float on, match:class ^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "float on, match:class ^(nwg-look|qt5ct|qt6ct|[Yy]ad)$"
        "float on, match:class (xdg-desktop-portal-gtk)"
        "float on, match:class ^(gnome-disks|wihotspot(-gui)?)$"
        "float on, match:class ^([Rr]ofi)$"
        "float on, match:class ^(file-roller|org.gnome.FileRoller)$"
        "float on, match:class ^(nm-applet|nm-connection-editor|blueman-manager)$"
        "float on, match:class ^([Ff]erdium)$"
        "float on, match:title ^(RuneScape)$"
        "float on, match:title ^(Picture-in-Picture)$"
        "float on, match:class ^(mpv|com.github.rafostar.Clapper)$"
        "float on, match:title ^(Authentication Required)$"
        "float on, match:class (codium|codium-url-handler|VSCodium), match:title negative:(.*codium.*|.*VSCodium.*)"
        "float on, match:class ^(com.heroicgameslauncher.hgl)$, match:title negative:(Heroic Games Launcher)"
        "float on, match:class ^([Ss]team)$, match:title negative:^([Ss]team)$"
        "float on, match:class ^([Tt]hunar)$, match:title negative:(.*[Tt]hunar.*)"
        "float on, match:initial_title (Add Folder to Workspace)"
        "float on, match:initial_title (Open Files)"
        "float on, match:initial_title (wants to save)"
        "float on, match:class (clipse)"
        "float on, match:class (looking-glass-client)"
        "float on, match:class (.virt-manager-wrapped)"
        "float on, match:class (org-rspeer-Inubot)"
        "float on, match:class (org-dreambot-Boot)"
        "size 70% 60%, match:initial_title (Open Files)"
        "size 70% 60%, match:initial_title (Add Folder to Workspace)"
        "size 70% 70%, match:class ^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$"
        "size 70% 70%, match:class ^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "size 70% 70%, match:class ^(nwg-look|qt5ct|qt6ct|[Yy]ad)$"
        "size 70% 70%, match:class (xdg-desktop-portal-gtk)"
        "size 70% 70%, match:class ^(gnome-disks|wihotspot(-gui)?)$"
        "size 70% 70%, match:class ^([Rr]ofi)$"
        "size 70% 70%, match:class ^(file-roller|org.gnome.FileRoller)$"
        "size 70% 70%, match:class ^(nm-applet|nm-connection-editor|blueman-manager)$"
        "size 60% 70%, match:class ^([Ff]erdium)$"
        "size 2560 1440, match:class (looking-glass-client)"
        "size 622 652, match:class (clipse)"
        "opacity 1.0 1.0, match:class ^(Brave-browser(-beta|-dev|-unstable)?)$"
        "opacity 1.0 1.0, match:class ^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
        "opacity 1.0 1.0, match:class ^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$"
        "opacity 1.0 1.0, match:class ^([Tt]horium-browser|[Cc]achy-browser)$"
        "opacity 0.9 0.8, match:class ^(codium|codium-url-handler|VSCodium)$"
        "opacity 0.9 0.8, match:class ^(VSCode|code-url-handler)$"
        "opacity 0.94 0.86, match:class ^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"
        "opacity 0.94 0.86, match:class ^([Ff]erdium)$"
        "opacity 0.94 0.86, match:class ^([Ww]hatsapp-for-linux)$"
        "opacity 0.94 0.86, match:class ^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$"
        "opacity 0.94 0.86, match:class ^(teams-for-linux)$"
        "opacity 0.9 0.8, match:class ^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$"
        "opacity 0.9 0.8, match:class ^(.*RuneLite)$"
        "opacity 0.95 0.9, match:class ^jetbrains-.*$"
        "opacity 0.8 0.7, match:class ^(Alacritty|kitty|kitty-dropterm)$"
        "opacity 0.8 0.7, match:class ^(gedit|org.gnome.TextEditor|mousepad)$"
        "opacity 0.9 0.8, match:class ^(seahorse)$"
        "opacity 0.95 0.75, match:title ^(Picture-in-Picture)$"
        "opacity 0.9 0.8, match:class ^(code)$"
        "pin on, match:title ^(Picture-in-Picture)$"
        "keep_aspect_ratio on, match:title ^(Picture-in-Picture)$"
        "no_blur on, match:class ^(gamescope)$"
        "no_focus on, match:class ^(net-runelite-client-RuneLite)$, match:title ^win\\d+$"
        "no_initial_focus on, match:class ^(net-runelite-client-RuneLite)$, match:title ^win\\d+$"
      ];

      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM, wayland:xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, wayland"
        "MOZ_ENABLE_WAYLAND, 1"
        "AQ_DRM_DEVICES, /dev/dri/card1:/dev/dri/card0"
        "GDK_SCALE, 1"
        "QT_SCALE_FACTOR, 1"
        "EDITOR, nano"
        "LIBVA_DRIVER_NAME, nvidia"
        "GBM_BACKEND, nvidia-drm"
        "XCURSOR_SIZE, 24"
        "XCURSOR_THEME, Bibata-Modern-Classic"
        "_JAVA_AWT_WM_NONREPARENTING, 1"
        "__GLX_VENDOR_LIBRARY_NAME, nvidia"
        "NVD_BACKEND, direct"
      ];
    };

    extraConfig = "
      monitor=,preferred,auto,auto
      ${extraMonitorSettings}
    ";
  };
}
