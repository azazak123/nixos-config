{ pkgs, config, lib, currentSystem, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/material-palenight.yaml";

    image = config.lib.stylix.pixel "base00";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font Propo";
      };
      sizes = {
        applications = if currentSystem == "x86_64-linux" then 14 else 18;
        terminal     = if currentSystem == "x86_64-linux" then 16 else 20;
        popups       = if currentSystem == "x86_64-linux" then 15 else 17;
      };
    };
  } // lib.optionalAttrs (currentSystem == "x86_64-linux") {
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    noto-fonts-color-emoji
    corefonts
  ];
}
