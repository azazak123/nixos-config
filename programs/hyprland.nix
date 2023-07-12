{
  enable = true;
  extraConfig = ''
    monitor = eDP-1, 1920x1080, 0x0, 1.15
        
    input {
        kb_layout = us, ua
        kb_options = grp:lalt_lshift_toggle 
    }

    general {
        gaps_out = 8
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
    }

    decoration {
        rounding = 5
        blur = true
        blur_size = 3
        blur_passes = 1
        blur_new_optimizations = on

        drop_shadow = false
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
    }

    animations {
        enabled = false 
    }

    dwindle {
        pseudotile = yes
        preserve_split = yes
    }

    # Binds
    $mainMod = SUPER

    bind = $mainMod, 36, exec, alacritty
    bind = $mainMod, Q, killactive, 
    bind = $mainMod, M, exit, 
    bind = $mainMod_SHIFT, 36, exec, thunar
    bind = $mainMod, V, togglefloating, 
    bind = CTRL_SHIFT, A, exec, wofi --show drun
    bind = $mainMod, F, fullscreen, 1
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle
    bind = CTRL, P, exec, grim -g "$(slurp)" - | wl-copy

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    # Brightness
    bind = , 232, exec, brightnessctl s 5%-
    bind = , 233, exec, brightnessctl s 5%+

    # Window rules
    windowrule = workspace 1,^(firefox)$
    windowrule = workspace 6,^(Alacritty)$
    windowrule = workspace 8,^(org.telegram.desktop)$
  '';
}
