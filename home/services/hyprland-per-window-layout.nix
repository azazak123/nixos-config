{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [ pkgs-unstable.hyprland-per-window-layout ];
  
  systemd.user.services.hyprland-per-window-layout = {
    Unit = {
      Description = "hyprland-per-window-layout";
      WantedBy = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs-unstable.hyprland-per-window-layout}/bin/hyprland-per-window-layout";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
      Environment = "PATH=${pkgs.hyprland}/bin";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
