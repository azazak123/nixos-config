{ config, lib, pkgs, ... }:
{
  services.kavita = {
    enable = true;
    tokenKeyFile = config.sops.secrets."kavita/token".path;
  };
}
