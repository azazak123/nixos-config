{ config, lib, pkgs, ... }:
{
  # Some services depend on sops, so we need it here
  sops = {
    defaultSopsFile = ../../../secrets/yomi.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      "ddclient/password" = {};
      "kavita/token" = {
        owner = "kavita";
      };
    };
  };

  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-vdpau-driver
      intel-compute-runtime-legacy1
      vpl-gpu-rt
    ];
  };

  systemd.services.transmission.serviceConfig = {
    Restart = "always";
    RestartSec = 30;
  };

  systemd.tmpfiles.rules = [
    "d /mnt/datavault/photo/immich 0755 immich immich -"
    "d /mnt/datavault/vault 0777 nobody nogroup -"
    "d /mnt/mediatank/tmp 0777 nobody nogroup -"
    "d /mnt/mediatank/data/downloads/transmission 0775 transmission multimedia - -"
    "d /mnt/mediatank/data/media/arr/shows 0775 sonarr multimedia - -"
    "d /mnt/mediatank/data/media/arr/movies 0775 radarr multimedia - -"
    "d /home/azazak123/containers/wishlist/uploads 0775 root - - -"
    "d /home/azazak123/containers/wishlist/data 0775 root - - -"
    "d /var/lib/moonraker 0775 moonraker moonraker - -"
  ];

  programs = {
    fish.enable = true;
    git.enable = true;
    direnv.enable = true;
  };
}
