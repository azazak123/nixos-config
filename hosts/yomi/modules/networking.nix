{ config, lib, pkgs, ... }:
{
  networking.hostName = "yomi";
  networking.hostId = "12345678";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      8000
      8082
      80
      443
      7777
      7125
      5000
    ];
  };
}
