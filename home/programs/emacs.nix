{ pkgs, currentSystem, ... }:

{

  services.emacs = {
    enable = currentSystem == "x86_64-linux";
    startWithUserSession = "graphical";
  };

  stylix.targets.emacs.enable = false;

  programs.emacs = {
    enable = true;
    package = if currentSystem == "x86_64-linux" then pkgs.emacs-pgtk else pkgs.emacs-macport;
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
      epkgs.jinx
    ];
  };

  xdg.configFile = {
    "emacs/init.el".source = ../dotfiles/emacs/init.el;
    "emacs/early-init.el".source = ../dotfiles/emacs/early-init.el;
    "emacs/modules".source = ../dotfiles/emacs/modules;
  };

  # programs.doom-emacs = {
  #   enable = true;
  #   doomDir = ../dotfiles/doom.d;
  # };
}
