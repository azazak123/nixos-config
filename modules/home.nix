{ pkgs, pkgsUnstable, vscodeExt, hyprland, ... }:

{
  users.users.azazak123 = {
    isNormalUser = true;
    description = "Volodymyr Antonov";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.azazak123 = { pkgs, ... }: {
    imports = [
      hyprland.homeManagerModules.default
    ];

    home.username = "azazak123";
    home.homeDirectory = "/home/azazak123";

    home.packages = with pkgs; [
      distrobox
      gammastep
      brightnessctl
    ];

    programs.home-manager.enable = true;

    wayland.windowManager.hyprland = import ../programs/hyprland.nix;
    
    programs.wofi.enable = true;

    programs.git = {
      enable = true;
      userName = "Volodymyr Antonov";
      userEmail = "azazaka2002@gmail.com";
    };

    programs.vscode = import ../programs/vscode.nix {
      inherit pkgs;
      inherit pkgsUnstable;
      inherit vscodeExt;
    };

    programs.helix.enable = true;

    programs.fish.enable = true;

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    programs.alacritty = import ../programs/alacritty.nix;

    # Services
    systemd.user.services.gammastep = import ../services/gammastep.nix { inherit pkgs; };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "23.05";
  };
}
