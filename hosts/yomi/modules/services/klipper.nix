{ config, lib, pkgs, ... }:
{
  services.klipper = {
    enable = true;
    user = "moonraker";
    group = "moonraker";
    mutableConfig = true;
    configDir = "/var/lib/moonraker/config";
    configFile = ./../../printer.cfg;
    logFile = "/var/lib/moonraker/logs/klipper.log";
  };

  services.mainsail = {
    enable = true;
    nginx = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 7777;
        }
      ];
    };
  };

  services.moonraker = {
    enable = true;
    address = "0.0.0.0";
    settings = {
      octoprint_compat = { };
      history = { };
      authorization = {
        force_logins = true;
        cors_domains = [
          "*.local"
          "*.lan"
          "*://app.fluidd.xyz"
          "*://my.mainsail.xyz"
        ];
        trusted_clients = [
          "10.0.0.0/8"
          "127.0.0.0/8"
          "169.254.0.0/16"
          "172.16.0.0/12"
          "192.168.0.0/24"
          "192.168.50.0/24"
          "0.0.0.0"
          "FE80::/10"
          "::1/128"
        ];
      };
    };
  };
}
