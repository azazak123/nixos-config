{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  vscodeExt,
  inputs,
  currentSystem,
  ...
}:

{
  users.users.azazak123 = {
    description = "Volodymyr Antonov";
      home = if currentSystem == "x86_64-linux" then "/home/azazak123" else "/Users/azazak123";
  } // lib.optionalAttrs (currentSystem == "x86_64-linux") {
    isNormalUser = true;
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
    inherit pkgs-unstable vscodeExt inputs currentSystem;
  };

  home-manager.users.azazak123 =
    { pkgs, currentSystem, ... }:
    {
      imports = [
        # External inputs
        inputs.nix-doom-emacs-unstraightened.hmModule

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
        ] ++ lib.optionals (currentSystem == "x86_64-linux") [
        # Desktop environment & Linux-only modules
        ../programs/hyprland.nix
        ../programs/waybar.nix
        ../programs/fuzzel.nix
        ../services/dunst.nix
        ../services/gnome-authentication-agent.nix
        ../services/hyprland-per-window-layout.nix
        ../services/wl-clip-persist.nix
        ../programs/scroll.nix

      ];

      systemd = lib.mkIf (currentSystem == "x86_64-linux") {
        user.sessionVariables = {
          NIXOS_OZONE_WL = "1";
          XDG_SESSION_TYPE = "wayland";
        };
      };

      home.username = "azazak123";
      home.homeDirectory = if currentSystem == "x86_64-linux" then "/home/azazak123" else "/Users/azazak123";
      
      home.stateVersion = "25.11";

      gtk.enable = lib.mkForce (currentSystem == "x86_64-linux");

      nix.gc = lib.mkIf (currentSystem == "x86_64-linux") {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      home.packages =
        with pkgs;
        [
          # Communication
          discord
          telegram-desktop
          element-desktop
          zoom-us

          # Office
          hunspell
          hunspellDicts.uk_UA
          hunspellDicts.en_US
          enchant
          obsidian

          # Media
          spotify
          spotube
          mpv

          # Games
          dolphin-emu

          # Code
          podman-compose

          # 3D Printing & Other

      ] ++ lib.optionals (currentSystem == "aarch64-darwin") [
          # macOS-only packages
          alt-tab-macos
          ghostty-bin
      ] ++ lib.optionals (currentSystem == "x86_64-linux") [
          # Wayland & Linux specific tools
          wlogout
          wl-clipboard
          wtype
          wl-clip-persist
          swaykbdd

          # Screenshots
          hyprshot
          slurp
          grim

          # Linux-only communication & tools
          teams-for-linux
          distrobox

          # Linux-only media
          delfin

          # Linux-only gaming
          heroic

          # Linux-only office & utilities
          libreoffice
          kdePackages.okular
          onlyoffice-desktopeditors

          # Desktop
          gnome-boxes
          bemoji

          # 3D Printing
          orca-slicer
          openscad-unstable
        ];

      programs.home-manager.enable = true;

      # Terminal utilities
      programs.yazi = {
        enable = true;
        shellWrapperName = "y";
      };
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
        settings = {
          "*" = {
            AddKeysToAgent = "yes";
            controlMaster = "auto";
            controlPath = "~/.ssh/%r@%h:%p";
            controlPersist = "10m";
            ServerAliveInterval = "30";
            ServerAliveCountMax = "3";
          };
        };
      };

      # Linux-only services
      services.ssh-agent.enable = currentSystem == "x86_64-linux";
      services.clipman.enable = currentSystem == "x86_64-linux";
      services.network-manager-applet.enable = currentSystem == "x86_64-linux";

      services.syncthing = {
        enable = false;
        tray = {
          enable = false;
          command = "syncthingtray --wait";
        };
      };
    };
}
