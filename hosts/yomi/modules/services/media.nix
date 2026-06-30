{ config, lib, pkgs, ... }:
{
  services.immich = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
    mediaLocation = "/mnt/datavault/photo/immich";
  };

  services.filebrowser = {
    enable = true;
    openFirewall = true;
    user = "nobody";
    group = "nogroup";
    settings = {
      address = "0.0.0.0";
      port = 1212;
      root = "/mnt/datavault/vault";
    };
  };

  services.sonarr = {
    enable = true;
    group = "multimedia";
    openFirewall = true;
  };

  services.radarr = {
    enable = true;
    group = "multimedia";
    openFirewall = true;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    openFirewall = true;
    group = "multimedia";
    settings = {
      download-dir = "/mnt/mediatank/data/downloads/transmission/downloaded";
      incomplete-dir = "/mnt/mediatank/data/downloads/transmission/.incomplete";
      umask = 2;
    };
  };

  services.jellyfin = {
    enable = true;
    group = "multimedia";
    openFirewall = true;
  };

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
  };
}
