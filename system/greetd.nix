{ pkgs, config, ... }:

{
  services.greetd = {
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
  };

  systemd.tmpfiles.rules = [
    "d /var/cache/tuigreet 0755 greeter greeter -"
  ];
}
