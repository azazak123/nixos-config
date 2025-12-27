{
  pkgs,
  config,
  ...
}:

{
  enable = true;
  useTextGreeter = true;
  settings = {
    initial_session = {
      command = "Hyprland";
      user = "azazak123";
    };

    default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --sessions ${config.services.xserver.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --theme 'window=magenta;border=magenta;prompt=cyan;input=white;action=blue;button=white;container=black'";
      user = "greeter";
    };
  };
}
