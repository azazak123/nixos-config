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
  boot.zfs.forceImportRoot = false;

  boot.kernelParams = [ "zfs.zfs_arc_max=8589934592" ];

  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 50;
    algorithm = "zstd";
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

  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    openFirewall = true;
    autoStart = false;
  };

  # Power button handled by logind, not Jovian's powerbuttond
  services.logind.settings.Login.HandlePowerKey = lib.mkOverride 90 "suspend";

  jovian = {
    steam = {
      enable = true;
      user = "azazak123";
    };
    hardware.has.amd.gpu = true;

    steamos.useSteamOSConfig = false;
  };

  networking.networkmanager.unmanaged = [
    "ap0"
    "wlp19s0f4u1i2"
  ];

  system.stateVersion = "23.05";
}
