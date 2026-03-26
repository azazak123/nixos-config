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
      command = "scroll";
      user = "azazak123";
    };

    default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
      user = "greeter";
    };
  };
}
