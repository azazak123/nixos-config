{ ... }:

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
      };

      terminal.shell = {
        program = "fish";
      };
    };
  };
}
