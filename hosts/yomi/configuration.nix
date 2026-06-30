{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./compose/excalidraw.nix

    ../../system/nix.nix

    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/users.nix
    ./modules/services/default.nix
    ./modules/extra.nix
    ./modules/virtualization.nix
    ./modules/environment.nix
  ];

  time.timeZone = "Europe/Kyiv";

  system.stateVersion = "25.05";
}
