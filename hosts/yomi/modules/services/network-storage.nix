{ config, lib, pkgs, ... }:
{
  services.ddclient = {
    enable = true;
    username = "azazak123.dedyn.io";
    server = "update.dedyn.io";
    passwordFile = config.sops.secrets."ddclient/password".path;
    domains = [
      "azazak123.dedyn.io"
    ];
  };

  services.samba = {
    package = pkgs.samba4Full;
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "guest account" = "nobody";
        "map to guest" = "Bad User";
        "create mask" = "0664";
        "directory mask" = "0775";
        "force create mode" = "0664";
        "force directory mode" = "0775";
      };
      tmp = {
        path = "/mnt/mediatank/tmp";
        writable = "true";
        browseable = "yes";
        "guest ok" = "yes";
      };
      data = {
        path = "/mnt/datavault/vault";
        writable = "true";
        browseable = "yes";
        "guest ok" = "yes";
      };
    };
  };

  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    nssmdns4 = true;
    enable = true;
    openFirewall = true;
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
