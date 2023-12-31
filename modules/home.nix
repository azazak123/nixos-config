{ pkgs-unstable, vscodeExt, ... }:

{
  users.users.azazak123 = {
    isNormalUser = true;
    description = "Volodymyr Antonov";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "dialout" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.azazak123 = { pkgs, ... }: {
    systemd.user.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    };

    home.username = "azazak123";
    home.homeDirectory = "/home/azazak123";

    home.packages = with pkgs; [
      distrobox
      gammastep
      polkit_gnome
      wlogout

      # Tools for taking screenshots
      grim
      slurp
      wl-clipboard

      # Programs
      discord
      spotify
      gnome.gnome-boxes
      telegram-desktop
      fluffychat
      zoom-us

      # Office
      libreoffice
      hunspell
      hunspellDicts.uk_UA
      hunspellDicts.en_US
      libsForQt5.okular

      podman-compose
    ] ++ (with pkgs-unstable; [
      hyprland-per-window-layout

      # https://github.com/IsmaelMartinez/teams-for-linux/issues/1001
      teams-for-linux
    ]);

    programs.home-manager.enable = true;

    programs.firefox.enable = true;

    # Wayland
    wayland.windowManager.hyprland = import ../programs/hyprland.nix { inherit (pkgs-unstable) hyprland; };

    programs.wofi.enable = true;

    programs.waybar = import ../programs/waybar.nix {
      inherit pkgs-unstable;
    };
    systemd.user.services.waybar.Service.Environment =
      "PATH=/run/wrappers/bin:${pkgs.hyprland}/bin";

    # Programming
    programs.git = {
      enable = true;
      userName = "Volodymyr Antonov";
      userEmail = "azazaka2002@gmail.com";
    };

    programs.vscode = import ../programs/vscode.nix {
      inherit pkgs pkgs-unstable vscodeExt;
    };

    programs.helix.enable = true;

    programs.fish.enable = true;

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    programs.alacritty = import ../programs/alacritty.nix;

    # Services
    # Enable warm light
    systemd.user.services.gammastep = import ../services/gammastep.nix {
      inherit pkgs;
    };

    # Enable per-window-layout
    systemd.user.services.hyprland-per-window-layout =
      import ../services/hyprland-per-window-layout.nix {
        inherit pkgs pkgs-unstable;
      };

    # Start Authentication Agent
    systemd.user.services.polkit-gnome-authentication-agent-1 =
      import ../services/gnome-authentication-agent.nix { inherit pkgs; };

    # Enable ssh agent
    services.gnome-keyring = {
      enable = true;
      components = [ "ssh" ];
    };

    # Enable notifications
    services.twmn = {
      enable = true;
      text = {
        font = {
          size = 18;
          family = "JetBrainsMono Nerd Font";
        };
        color = "white";
        maxLength = 80;
      };
      window = {
        height = 30;
        alwaysOnTop = true;
        color = "#2b303b";
        offset.y = 30;
      };
    };

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
