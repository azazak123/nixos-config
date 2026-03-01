# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  programs = ../../programs;
  services = ../../services;
  users = ../../users;
in
{
  imports = [
    ./hardware-configuration.nix

    # ./home.nix
    /${users}/azazak123.nix
  ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };

  # Desktop environment
  services.xserver = {
    enable = true;
    desktopManager = {
      xfce.enable = true;
    };

    # Configure keymap in X11
    xkb = {
      layout = "us,ua";
      variant = ",";
      options = "grp:alt_shift_toggle";
    };
  };

  services.greetd = import /${services}/greetd.nix { inherit pkgs config; };
  systemd.tmpfiles.rules = [
    "d /var/cache/tuigreet 0755 greeter greeter -"
  ];

  madness.enable = true;

  console = {
    earlySetup = true;

    font = "ter-v32n";
    packages = with pkgs; [ terminus_font ];

    colors = [
      "292D3E"
      "F07178"
      "C3E88D"
      "FFCB6B"
      "82AAFF"
      "C792EA"
      "89DDFF"
      "A6ACCD"
      "444267"
      "F07178"
      "C3E88D"
      "FFCB6B"
      "82AAFF"
      "C792EA"
      "89DDFF"
      "FFFFFF"
    ];
  };

  environment.xfce.excludePackages = with pkgs.xfce; [ xfce4-notifyd ];

  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };

  networking.hostName = "sakaki";
  networking.hostId = "12345678";
  networking.networkmanager.enable = true;

  services.zfs.trim.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Services
  # Enable automatic login for the user.
  services.getty.autologinUser = "azazak123";

  # Enable flatpak
  services.flatpak.enable = true;

  # Enable podman
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };
  # https://github.com/NixOS/nixpkgs/issues/414135
  security.lsm = lib.mkForce [ ];

  # Enable sound
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  # Enable avahi
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  nix = import /${programs}/nix-config.nix { inherit inputs lib config; };

  environment.systemPackages = with pkgs; [
    vim
    neofetch
    cpufrequtils
    htop
    ncpamixer
    brightnessctl
    simple-scan
    bluetui
    ncdu
    yazi
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    corefonts
  ];

  # Printers and scanners
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };
  services.ipp-usb.enable = true;
  services.printing.enable = true;

  # Games
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  system.stateVersion = "23.05";
}
