{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    helix
    htop
    fastfetch
    smartmontools
    lazygit
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
