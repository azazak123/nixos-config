{ pkgs, hyprland }:

{
  enable = true;
  systemd.enable = true;
  package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.waybar-hyprland;
  settings = {
    mainBar = {
      layer = "top";
      height = 30;
      spacing = 10;

      # Choose the order of the modules
      modules-left = [ "wlr/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "pulseaudio" "cpu" "memory" "temperature" "backlight" "battery" "clock" "tray" ];

      # Modules configuration
      "wlr/workspaces" = {
        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e-1";
        on-scroll-down = "hyprctl dispatch workspace e+1";
      };

      "hyprland/window" = {
        max-length = 75;
        separate-outputs = true;
      };

      tray = {
        spacing = 10;
      };

      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };

      cpu = {
        format = "CPU:{usage}%";
        tooltip = false;
      };

      memory = {
        format = "RAM:{}%";
      };

      temperature = {
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" ];
      };

      backlight = {
        format = "{percent}% {icon}";
        format-icons = [ "" "" "" "" "" "" "" "" "" ];
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% 󱐋";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        format-icons = [ "" "" "" "" "" ];
      };

      network = {
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr}/{cidr}";
        tooltip-format = "{ifname} via {gwaddr}";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "Disconnected ⚠";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
      };

      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon}  {format_source}";
        format-bluetooth-muted = " {icon}  {format_source}";
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          default = [ "" "" "" ];
        };
        on-click = "pavucontrol";
      };
    };
  };
  style = ''
    * {
        border: none;
        border-radius: 0;
        font-family: JetBrainsMono Nerd Font, EmojiOne Color;
        font-size: 15px;
        min-height: 0;
    }

    window#waybar {
        background: rgba(43, 48, 59, 0.5);
        border-bottom: 3px solid rgba(100, 114, 125, 0.5);
        color: #FFFFFF;
    }

    #window, #tray, #clock, #battery, #backlight, #temperature, #memory, #cpu, #network, #pulseaudio, #mpd {
        padding: 0 10px;
    }

    #workspaces button.active {
        background: #64727D;
        border-bottom: 3px solid #FFFFFF;
    }

    #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #FFFFFF;
        border-bottom: 3px solid transparent;
    }
  '';
}
