{ config, pkgs, lib, ... }:

let
  myLayout = "colemak";

  k = if myLayout == "colemak" then {
    left = "a"; down = "r"; up = "w"; right = "s";
  } else {
    left = "a"; down = "s"; up = "w"; right = "d";
  };
  
  variant = if myLayout == "colemak" then "colemak," else ",";
in
{
  xdg.configFile."scroll/config".text = ''
    include /etc/scroll/config.d/*

    exec swaykbdd

    exec_always "systemctl --user import-environment WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP && systemctl --user restart waybar"

    set $mod Mod4

    output * adaptive_sync on
    
    output HDMI-A-1 resolution 1920x1080 position 0 0 scale 1
    output eDP-1 resolution 1920x1080 position 1920 0 scale 1.2
    
    input * {
        xkb_layout "us,ua"
        xkb_variant "${variant}"
        xkb_options "grp:menu_toggle"
    }

    floating_modifier $mod normal

    animations {
        enabled no
    }

    gaps inner 8
    gaps outer 0
    default_border pixel 2

    focus_follows_mouse full
    maximize_if_single true

    bindsym --to-code $mod+Return exec alacritty
    bindsym --to-code $mod+Shift+Return exec thunar
    bindsym --to-code $mod+q kill
    bindsym --to-code $mod+m exec swaymsg exit
    bindsym --to-code $mod+v floating toggle
    bindsym --to-code $mod+Ctrl+f fullscreen toggle
    bindsym --to-code $mod+f toggle_size this 1.0 1.0
    bindsym --to-code $mod+x exec wlogout

    # Dmenu / Fuzzel
    bindsym --to-code Ctrl+Shift+a exec fuzzel
    bindsym --to-code Ctrl+Shift+s exec "clipman pick --tool=CUSTOM --tool-args='fuzzel -d' && wtype -M ctrl v -m ctrl"
    bindsym --to-code Ctrl+Shift+e exec "BEMOJI_PICKER_CMD='fuzzel -d' bemoji -t"

    bindsym --to-code $mod+Shift+s exec grim -g "$(slurp)" - | wl-copy

    bindsym --to-code $mod+Mod1+${k.left} focus left
    bindsym --to-code $mod+Mod1+${k.down} focus down
    bindsym --to-code $mod+Mod1+${k.up} focus up
    bindsym --to-code $mod+Mod1+${k.right} focus right

    bindsym --to-code --no-repeat $mod+tab scale_workspace overview; jump

    bindsym --to-code $mod+1 workspace number 1
    bindsym --to-code $mod+2 workspace number 2
    bindsym --to-code $mod+3 workspace number 3
    bindsym --to-code $mod+4 workspace number 4
    bindsym --to-code $mod+5 workspace number 5
    bindsym --to-code $mod+6 workspace number 6
    bindsym --to-code $mod+7 workspace number 7
    bindsym --to-code $mod+8 workspace number 8
    bindsym --to-code $mod+9 workspace number 9
    bindsym --to-code $mod+0 workspace number 10

    bindsym --to-code $mod+Shift+1 move container to workspace number 1
    bindsym --to-code $mod+Shift+2 move container to workspace number 2
    bindsym --to-code $mod+Shift+3 move container to workspace number 3
    bindsym --to-code $mod+Shift+4 move container to workspace number 4
    bindsym --to-code $mod+Shift+5 move container to workspace number 5
    bindsym --to-code $mod+Shift+6 move container to workspace number 6
    bindsym --to-code $mod+Shift+7 move container to workspace number 7
    bindsym --to-code $mod+Shift+8 move container to workspace number 8
    bindsym --to-code $mod+Shift+9 move container to workspace number 9
    bindsym --to-code $mod+Shift+0 move container to workspace number 10

    bindsym --to-code $mod+${k.right} workspace next
    bindsym --to-code $mod+${k.left} workspace prev

    bindsym XF86MonBrightnessDown exec brightnessctl s 5%-
    bindsym XF86MonBrightnessUp exec brightnessctl s 5%+
    bindsym XF86AudioRaiseVolume exec wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
    bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindsym XF86AudioMicMute exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

    bindsym Ctrl+F6 output HDMI-A-1 resolution 1920x1080@60Hz position 0 0 scale 1
    bindsym Ctrl+F7 output HDMI-A-1 resolution 1920x1080@100Hz position 0 0 scale 1
    
    bindsym Ctrl+F8 output eDP-1 disable
    
    bindsym Ctrl+F9 output eDP-1 enable, output eDP-1 resolution 1920x1080 position 1920 0 scale 1.2

    workspace 1 output HDMI-A-1
    workspace 6 output HDMI-A-1
    workspace 8 output eDP-1

    assign [app_id="firefox"] workspace 1
    assign [class="firefox"] workspace 1
    assign [app_id="org.telegram.desktop"] workspace 8
    assign [class="TelegramDesktop"] workspace 8

    for_window [app_id="zoom" title="menu window"] floating enable

    include /etc/scroll/config.d/*
  '';
}
