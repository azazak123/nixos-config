{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      general.live_config_reload = true;

      keyboard.bindings = [
        { key = "Minus"; mods = "Control"; action = "ReceiveChar"; }
        { key = "Equals"; mods = "Control"; action = "ReceiveChar"; }
        { key = "Plus"; mods = "Control"; action = "ReceiveChar"; }
        { key = "Key0"; mods = "Control"; action = "ReceiveChar"; }
      ];

      window = {
        opacity = 1.0;

        padding = {
          x = 10;
          y = 10;
        };

        decorations = "None";

        dimensions = {
          columns = 0;
          lines = 0;
        };
        startup_mode = "Maximized";
      };

      terminal.shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "--login" ];
      };
    };
  };
}
