{ host, ... }:
let
  inherit (import ../../../hosts/${host}/variables.nix)
    browser
    terminal
    ;
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$modifier,Return,exec,${terminal}"
      "$modifier SHIFT,Return,exec,rofi-launcher"
      "$modifier SHIFT,W,exec,web-search"
      "$modifier ALT,W,exec,wallsetter"
      "$modifier SHIFT,N,exec,swaync-client -rs"
      "$modifier,W,exec,${browser}"
      "$modifier,S,exec,screen-capture"
      "$modifier SHIFT,S,exec,screen-record"
      "$modifier,D,exec,discord"
      "$modifier,O,exec,obs"
      "$modifier,C,exec,hyprpicker -a"
      "$modifier,G,submap,cursor"
      "$modifier,T,exec,pypr toggle term"
      # "$modifier,V,exec,${terminal} --class clipse -e 'clipse'"
      "$modifier SHIFT,F8,exec,autoclicker"
      "$modifier SHIFT,T,exec,pypr toggle thunar"
      "$modifier,M,exec,pavucontrol"
      "$modifier,Q,killactive,"
      "$modifier,P,exec,pypr toggle volume"
      "$modifier SHIFT,P,pseudo,"
      "$modifier SHIFT,I,togglesplit,"
      "$modifier,F,fullscreen,"
      "$modifier SHIFT,F,togglefloating,"
      "$modifier CONTROL,F,fullscreen, 1"
      "$modifier ALT,F,workspaceopt, allfloat"
      "$modifier SHIFT,C,exit,"
      "$modifier SHIFT,Z,pin,active"
      "$modifier SHIFT,left,movewindow,l"
      "$modifier SHIFT,right,movewindow,r"
      "$modifier SHIFT,up,movewindow,u"
      "$modifier SHIFT,down,movewindow,d"
      "$modifier SHIFT,h,movewindow,l"
      "$modifier SHIFT,l,movewindow,r"
      "$modifier SHIFT,k,movewindow,u"
      "$modifier SHIFT,j,movewindow,d"
      "$modifier ALT, left, swapwindow,l"
      "$modifier ALT, right, swapwindow,r"
      "$modifier ALT, up, swapwindow,u"
      "$modifier ALT, down, swapwindow,d"
      "$modifier ALT, 43, swapwindow,l"
      "$modifier ALT, 46, swapwindow,r"
      "$modifier ALT, 45, swapwindow,u"
      "$modifier ALT, 44, swapwindow,d"
      "$modifier,left,movefocus,l"
      "$modifier,right,movefocus,r"
      "$modifier,up,movefocus,u"
      "$modifier,down,movefocus,d"
      "$modifier,h,movefocus,l"
      "$modifier,l,movefocus,r"
      "$modifier,k,movefocus,u"
      "$modifier,j,movefocus,d"
      "$modifier,1,workspace,1"
      "$modifier,2,workspace,2"
      "$modifier,3,workspace,3"
      "$modifier,4,workspace,4"
      "$modifier,5,workspace,5"
      "$modifier,6,workspace,6"
      "$modifier,7,workspace,7"
      "$modifier,8,workspace,8"
      "$modifier,9,workspace,9"
      "$modifier,0,workspace,10"
      "$modifier SHIFT,SPACE,movetoworkspace,special"
      "$modifier,SPACE,togglespecialworkspace"
      "$modifier SHIFT,1,movetoworkspace,1"
      "$modifier SHIFT,2,movetoworkspace,2"
      "$modifier SHIFT,3,movetoworkspace,3"
      "$modifier SHIFT,4,movetoworkspace,4"
      "$modifier SHIFT,5,movetoworkspace,5"
      "$modifier SHIFT,6,movetoworkspace,6"
      "$modifier SHIFT,7,movetoworkspace,7"
      "$modifier SHIFT,8,movetoworkspace,8"
      "$modifier SHIFT,9,movetoworkspace,9"
      "$modifier SHIFT,0,movetoworkspace,10"
      "$modifier CONTROL,right,workspace,e+1"
      "$modifier CONTROL,left,workspace,e-1"
      "$modifier,mouse_down,workspace, e+1"
      "$modifier,mouse_up,workspace, e-1"
      "ALT,Tab,cyclenext"
      "ALT,Tab,bringactivetotop"
      ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioPlay, exec, playerctl play-pause"
      ",XF86AudioPause, exec, playerctl play-pause"
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioPrev, exec, playerctl previous"
      ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
      ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
    ];

    bindm = [
      "$modifier,mouse:274,togglefloating"
      "$modifier,mouse:272,movewindow"
      "$modifier,mouse:273,resizewindow"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = ''
    submap = cursor

    # Movement (repeats when held)
    binde = , h, exec, wlrctl pointer move -20 0
    binde = , l, exec, wlrctl pointer move 20 0
    binde = , k, exec, wlrctl pointer move 0 -20
    binde = , j, exec, wlrctl pointer move 0 20

    # Specifics
    bind = , z, exec, if [ -f /tmp/cursor_dir ]; then wlrctl pointer move 20 0 && rm /tmp/cursor_dir; else wlrctl pointer move -20 0 && touch /tmp/cursor_dir; fi

    # Faster movement with shift
    binde = SHIFT, h, exec, wlrctl pointer move -80 0
    binde = SHIFT, l, exec, wlrctl pointer move 80 0
    binde = SHIFT, k, exec, wlrctl pointer move 0 -80
    binde = SHIFT, j, exec, wlrctl pointer move 0 80

    # Clicks
    bind = , s, exec, wlrctl pointer click left
    bind = , a, exec, wlrctl pointer click left && sleep 0.1 && wlrctl pointer click left
    bind = , d, exec, wlrctl pointer click middle
    bind = , f, exec, wlrctl pointer click right

    # Scroll
    binde = , e, exec, wlrctl pointer scroll -10 0
    binde = , r, exec, wlrctl pointer scroll 10 0

    # Exit cursor mode
    bind = , escape, submap, reset

    submap = reset
  '';
}