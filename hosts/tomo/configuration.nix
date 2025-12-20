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
in

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # User configuration
    ./home.nix
  ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  networking.hostName = "tomo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neofetch
    cpufrequtils
    htop
    ncpamixer
    brightnessctl
    simple-scan
    bluetui
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-emoji
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
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
