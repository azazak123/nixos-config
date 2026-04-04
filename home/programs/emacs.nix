{ pkgs, ... }:

{
  services.emacs.enable = false;
  stylix.targets.emacs.enable = false;
  
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
    ];
  };
  
  xdg.configFile."emacs/init.el".source = ../dotfiles/emacs/init.el;
  xdg.configFile."emacs/early-init.el".source = ../dotfiles/emacs/early-init.el;
  xdg.configFile."emacs/modules".source = ../dotfiles/emacs/modules;
  
  # programs.doom-emacs = {
  #   enable = true;
  #   doomDir = ../dotfiles/doom.d;
  # };
}
