{
  pkgs-unstable,
  vscodeExt,
  inputs,
  ...
}:

let
  programs = ../programs;
  services = ../services;
  configs = ../configs;
in
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

  home-manager.users.azazak123 =
    { pkgs, ... }:
    {
      imports = [ inputs.nix-doom-emacs-unstraightened.hmModule ];

      systemd.user.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        XDG_SESSION_TYPE = "wayland";
      };

      home.username = "azazak123";
      home.homeDirectory = "/home/azazak123";

      home.pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Ice";
        size = 36;
        gtk.enable = true;
      };

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

          # Screenshots
          hyprshot

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
          polkit_gnome
          gnome-boxes
          bemoji
          distrobox
          openscad-unstable
        ]
        ++ (with pkgs-unstable; [
          hyprland-per-window-layout
          lapce
          delfin
        ]);

      programs.home-manager.enable = true;

      # Browsers
      programs.firefox.enable = true;
      programs.floorp.enable = true;

      # Wayland / UI
      wayland.windowManager.hyprland = import /${programs}/hyprland.nix { inherit (pkgs) hyprland; };
      programs.fuzzel = import /${programs}/fuzzel.nix;
      programs.waybar = import /${programs}/waybar.nix { inherit pkgs-unstable; };

      # Terminal utilities
      programs.yazi.enable = true;
      programs.fzf.enable = true;
      programs.zellij = import /${programs}/zellij.nix;
      programs.alacritty = import /${programs}/alacritty.nix;
      programs.fish.enable = true;

      # Programming / Development
      programs.git = import /${programs}/git.nix;
      programs.gitui = import /${programs}/gitui.nix;
      programs.gh.enable = true;
      programs.vscode = import /${programs}/vscode.nix { inherit pkgs pkgs-unstable vscodeExt; };
      programs.helix = import /${programs}/helix.nix;
      
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
      
      # Emacs
      services.emacs.enable = true;
      programs.doom-emacs = {
        enable = true;
        doomDir = /${configs}/doom.d;
      };

      # Services
      services.gammastep = {
        enable = false;
        latitude = 50.0;
        longitude = 30.0;
        temperature = {
          day = 4000;
          night = 4000;
        };
      };

      systemd.user.services.hyprland-per-window-layout =
        import /${services}/hyprland-per-window-layout.nix
          { inherit pkgs pkgs-unstable; };

      systemd.user.services.polkit-gnome-authentication-agent-1 =
        import /${services}/gnome-authentication-agent.nix
          { inherit pkgs; };

      services.dunst = import /${services}/dunst.nix;

      services.clipman.enable = true;
      systemd.user.services.wl-clip-persist = import /${services}/wl-clip-persist.nix { inherit pkgs; };

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
