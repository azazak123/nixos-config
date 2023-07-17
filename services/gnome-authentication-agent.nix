{ pkgs }:

{
  Unit = {
    Description = "polkit-gnome-authentication-agent-1";
    WantedBy = [ "graphical-session.target" ];
    Wants = [ "graphical-session.target" ];
    After = [ "graphical-session.target" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Restart = "on-failure";
    RestartSec = 1;
    TimeoutStopSec = 10;
  };
  Install = {
    WantedBy = [ "graphical-session.target" ];
  };
}
