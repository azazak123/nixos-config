{ pkgs }:

{
  Service = {
    ExecStart = ''
      ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular
    '';
  };
  Install = {
    WantedBy = [ "graphical-session.target" ];
  };
}
