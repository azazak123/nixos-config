{ hyprland }:
{
  enable = true;
  package = hyprland;
  settings = {
    monitor = [
      "eDP-1, 1920x1080, 1920x0, 1.20"
      "desc:ASR CL25FF 000000000000, highrr, 0x0, 1"
      ", preferred, auto, 1"
    ];

    misc = {
      vrr = 1;
    };

    xwayland = {
      force_zero_scaling = true;
    };

    input = {
      kb_layout = "us, ua";
      kb_options = "grp:lalt_lshift_toggle";
    };

    general = {
      gaps_out = 8;
      border_size = 2;
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
    };

    decoration = {
      rounding = 5;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        new_optimizations = "on";
      };
      shadow = {
        enabled = false;
        range = 4;
        render_power = 3;
      };
    };

    animations = {
      enabled = false;
    };

    dwindle = {
      pseudotile = "yes";
      preserve_split = "yes";
    };

    "$mainMod" = "SUPER";

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bind = [
      "$mainMod, 36, exec, alacritty"
      "$mainMod, Q, killactive"
      "$mainMod, M, exit"
      "$mainMod_SHIFT, 36, exec, thunar"
      "$mainMod, V, togglefloating"
      "$mainMod, F, fullscreen, 1"
      "$mainMod, P, pseudo" # dwindle
      "$mainMod, J, togglesplit" # dwindle
      "$mainMod SHIFT, S, exec, hyprshot -m region --clipboard-only"
      "$mainMod, X, exec, wlogout"

      # Dmenu
      "CTRL_SHIFT, A, exec, fuzzel"
      "CTRL_SHIFT, S, exec, clipman pick --tool=CUSTOM --tool-args='fuzzel -d' && wtype -M ctrl v -m ctrl"
      "CTRL_SHIFT, E, exec, BEMOJI_PICKER_CMD='fuzzel -d' bemoji -t"

      # Move focus with mainMod + arrow keys
      "$mainMod&ALT, a, movefocus, l"
      "$mainMod&ALT, d, movefocus, r"
      "$mainMod&ALT, s, movefocus, d"
      "$mainMod&ALT, w, movefocus, u"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Move through existing workspaces
      "$mainMod, d, workspace, e+1"
      "$mainMod, a, workspace, e-1"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      # Move workspace to monitor with CTRL + number
      "CTRL, 1, movecurrentworkspacetomonitor, 0"
      "CTRL, 2, movecurrentworkspacetomonitor, 1"

      # Brightness
      ", 232, exec, brightnessctl s 5%-"
      ", 233, exec, brightnessctl s 5%+"
    ];

    workspace = [
      "1, monitor:HDMI-A-1, default:true"
      "6, monitor:HDMI-A-1"
      "8, monitor:eDP-1"
    ];

    windowrule = [
      "workspace 1, class:(firefox)"
      "workspace 8, class:(org.telegram.desktop)"
      "stayfocused, class:(zoom), initialTitle:(menu window)"
    ];
  };
}
