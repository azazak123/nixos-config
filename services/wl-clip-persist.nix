{ pkgs }:

{
  Service = {
    ExecStart = ''
      ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both
    '';
  };
  Install = {
    WantedBy = [ "graphical-session.target" ];
  };
}
