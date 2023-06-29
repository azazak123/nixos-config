{ pkgs }:

{
  Service = {
    ExecStart = ''
      ${pkgs.gammastep}/bin/gammastep -PO 4000
    '';
  };
  Install = {
    WantedBy = [ "graphical-session.target" ];
  };
}
