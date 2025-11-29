{
  pkgs-unstable,
  vscodeExt,
  inputs,
  ...
}:

let
  programs = ../../programs;
  services = ../../services;
  configs = ../../configs;
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
        SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
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
        frequency = "weekly";
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
          grimblast

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
          libsForQt5.okular

          # Media
          spotify
          spotube
          mpv

          # Games
          dolphin-emu

          #Code
          podman-compose

          # Other
          polkit_gnome
          gnome-boxes
          bemoji
          distrobox
        ]
        ++ (with pkgs-unstable; [
          hyprland-per-window-layout

          lapce

          delfin
        ]);

      programs.home-manager.enable = true;

      programs.firefox.enable = true;

      # Wayland
      wayland.windowManager.hyprland = import /${programs}/hyprland.nix { inherit (pkgs) hyprland; };

      programs.fuzzel = import /${programs}/fuzzel.nix;

      programs.waybar = import /${programs}/waybar.nix { inherit pkgs-unstable; };
      # systemd.user.services.waybar.Service.Environment = "PATH=/run/wrappers/bin:${pkgs.hyprland}/bin";

      # Programming
      programs.git = import /${programs}/git.nix;

      programs.vscode = import /${programs}/vscode.nix { inherit pkgs pkgs-unstable vscodeExt; };

      services.emacs.enable = true;
      programs.doom-emacs = {
        enable = true;
        doomDir = /${configs}/doom.d;
      };

      programs.helix = import /${programs}/helix.nix;

      programs.fish.enable = true;

      programs.direnv.enable = true;
      programs.direnv.nix-direnv.enable = true;

      programs.alacritty = import /${programs}/alacritty.nix;

      # Services
      # Enable warm light
      services.gammastep = {
        enable = true;
        latitude = 50.0;
        longitude = 30.0;
        temperature = {
          day = 4000;
          night = 4000;
        };
      };

      # Enable per-window-layout
      systemd.user.services.hyprland-per-window-layout =
        import /${services}/hyprland-per-window-layout.nix
          { inherit pkgs pkgs-unstable; };

      # Start Authentication Agent
      services.ssh-agent.enable = true;
      systemd.user.services.polkit-gnome-authentication-agent-1 =
        import /${services}/gnome-authentication-agent.nix
          { inherit pkgs; };

      # Enable ssh agent
      services.gnome-keyring = {
        enable = true;
        components = [
          "ssh"
          "secrets"
        ];
      };

      # Enable notifications
      services.dunst = import /${services}/dunst.nix;

      # Enable clipboard manager
      services.clipman.enable = true;

      # Enable clipboard persistence
      systemd.user.services.wl-clip-persist = import /${services}/wl-clip-persist.nix { inherit pkgs; };

      services.nextcloud-client = {
        enable = true;
        startInBackground = true;
      };

      services.syncthing = {
        enable = true;
        tray = {
          enable = true;
          command = "syncthingtray --wait";
        };
      };

      services.network-manager-applet.enable = true;

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
