{ pkgs-unstable }:

{
  enable = true;
  package = pkgs-unstable.waybar;
  systemd.enable = true;
  settings = {
    mainBar = {
      layer = "top";
      height = 30;
      spacing = 10;

      # Choose the order of the modules
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [
        "bluetooth"
        "pulseaudio"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "battery"
        "clock"
        "tray"
      ];

      # Modules configuration
      "hyprland/workspaces" = {
        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e-1";
        on-scroll-down = "hyprctl dispatch workspace e+1";
      };

      "hyprland/window" = {
        max-length = 75;
        separate-outputs = true;
      };

      bluetooth = {
        format = " {status}";
        format-disabled = "󰂲 Off";
        format-connected = " {device_alias}";
        format-connected-battery = " {device_alias} {device_battery_percentage}%";
        tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        on-click = "blueman-manager"; 
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
        interval = 10;
      };

      memory = {
        format = "RAM:{}%";
        interval = 10;
      };

      temperature = {
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" ];
        interval = 10;
      };

      backlight = {
        format = "{percent}% {icon}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
        ];
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
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
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
          default = [
            ""
            ""
            ""
          ];
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
        background: rgba(43, 48, 59, 1);
        border-bottom: 3px solid rgba(100, 114, 125, 1);
        color: #FFFFFF;
    }

    #window, #tray, #clock, #battery, #backlight, #temperature, #memory, #cpu, #network, #pulseaudio, #mpd, #bluetooth {
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
