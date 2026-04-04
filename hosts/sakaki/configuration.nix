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

  # Desktop environment
  services.xserver = {
    enable = true;
    desktopManager = {
      xfce.enable = true;
    };
  };
  programs.hyprland.enable = true;

  networking.hostName = "sakaki";
  networking.hostId = "12345678";
  networking.networkmanager.enable = true;

  services.zfs.trim.enable = true;

  system.stateVersion = "23.05";
}
