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

{
  imports = [
    ./hardware-configuration.nix

    ../../system/style.nix
    ../../system/gaming.nix
    ../../system/input.nix
    ../../system/scroll.nix
    ../../system/greetd.nix
    ../../system/nix.nix
    ../../system/core.nix
    ../../system/peripherals.nix
    ../../system/virtualization.nix

    ../../home/users/azazak123.nix
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
  };
  programs.hyprland.enable = true;

  networking.hostName = "tomo"; # Define your hostname.
  networking.networkmanager.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
