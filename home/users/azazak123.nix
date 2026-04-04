{
  pkgs-unstable,
  vscodeExt,
  inputs,
  ...
}:

{
  users.users.azazak123 = {
    isNormalUser = true;
    description = "Volodymyr Antonov";
    extraGroups = [
      "networkmanager"
      "wheel"
      "scanner"
      "lp"
      "dialout"
      "podman"
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { 
    inherit pkgs-unstable vscodeExt inputs;
  };

  home-manager.users.azazak123 =
    { pkgs, pkgs-unstable, ... }:
    {
      imports = [
        # External inputs
        inputs.nix-doom-emacs-unstraightened.hmModule

        # Desktop environment
        ../programs/hyprland.nix
        ../programs/scroll.nix
        ../programs/waybar.nix
        ../programs/fuzzel.nix

        # Terminal
        ../programs/alacritty.nix
        ../programs/zellij.nix

        # Browsers
        ../programs/firefox.nix
        ../programs/floorp.nix

        # Development
        ../programs/vscode.nix
        ../programs/helix.nix
        ../programs/emacs.nix
        ../programs/git.nix

        # Services
        ../services/dunst.nix
        ../services/gnome-authentication-agent.nix
        ../services/hyprland-per-window-layout.nix
        ../services/wl-clip-persist.nix
      ];

      systemd.user.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        XDG_SESSION_TYPE = "wayland";
      };

      home.username = "azazak123";
      home.homeDirectory = "/home/azazak123";

      gtk.enable = true;

      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      home.packages =
        with pkgs;
        [
          # Wayland
          wlogout
          wl-clipboard
          wtype
          wl-clip-persist
          swaykbdd

          # Screenshots
          hyprshot
          slurp
          grim

          # Communication
          discord
          teams-for-linux
          telegram-desktop
          element-desktop
          zoom-us

          # Office
          libreoffice
          hunspell
          hunspellDicts.uk_UA
          hunspellDicts.en_US
          kdePackages.okular
          obsidian
          onlyoffice-desktopeditors

          # Media
          spotify
          spotube
          mpv

          # Games
          dolphin-emu

          # Code
          podman-compose

          # 3D Printing
          orca-slicer

          # Other
          gnome-boxes
          bemoji
          distrobox
          openscad-unstable
        ];

      programs.home-manager.enable = true;

      # Terminal utilities
      programs.yazi.enable = true;
      programs.fzf.enable = true;
      programs.fish.enable = true;

      # Programming / Development
      programs.gitui.enable = true;
      programs.gh.enable = true;
      
      programs.direnv.enable = true;
      programs.direnv.nix-direnv.enable = true;

      # SSH
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks."*" = {
          addKeysToAgent = "yes";
        };
      };

      services.ssh-agent.enable = true;

      # Services
      services.clipman.enable = true;

      services.syncthing = {
        enable = true;
        tray = {
          enable = true;
          command = "syncthingtray --wait";
        };
      };

      services.network-manager-applet.enable = true;

      home.stateVersion = "23.05";
    };
}
