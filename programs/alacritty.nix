{
  enable = true;
  settings = {
    colors = {
      primary = {
        background = "#292D3E"; 
        foreground = "#A6ACCD"; 
      };

      cursor = {
        text = "#292D3E";
        cursor = "#82AAFF"; 
      };

      selection = {
        text = "#292D3E";
        background = "#82AAFF";
      };

      normal = {
        black = "#292D3E";
        red = "#F07178";
        green = "#C3E88D";
        yellow = "#FFCB6B";
        blue = "#82AAFF";
        magenta = "#C792EA";
        cyan = "#89DDFF";
        white = "#A6ACCD";
      };

      bright = {
        black = "#444267"; 
        red = "#F07178";
        green = "#C3E88D";
        yellow = "#FFCB6B";
        blue = "#82AAFF";
        magenta = "#C792EA";
        cyan = "#89DDFF";
        white = "#FFFFFF";
      };
    };

    font = {
      normal = {
        family = "JetBrainsMono Nerd Font";
        style = "Regular";
      };
      bold = {
        family = "JetBrainsMono Nerd Font";
        style = "Bold";
      };
      italic = {
        family = "JetBrainsMono Nerd Font";
        style = "Italic";
      };
      bold_italic = {
        family = "JetBrainsMono Nerd Font";
        style = "Bold Italic";
      };
      size = 15;
    };

    general.live_config_reload = true;

    window = {
      opacity = 0.95;

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
}
