{
  pkgs,
  modulesPath,
  lib,
  ...
}:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  services.openssh.enable = true;
  services.getty.autologinUser = "root";
  programs.git.enable = true;
  programs.fish.enable = true;

  users.groups.multimedia = { };

  home-manager.users.eve =
    { pkgs, ... }:
    {
      programs.beets.enable = true;
      programs.beets.config = {
        plugins = [
          "acousticbrainz"
          "chromaprint"
          "fetchart"
          "lastgenre"
          "replaygain"
          "web"
        ];
        directory = "/mnt/storage/Media/music";
        import = {
          copy = true;
        };
        paths = [
          "/mnt/storage/Media/temp"
        ];
      };

      systemd.user.services.gonic = {
        Unit = {
          After = [
            "network.target"
            "sound.target"
          ];
          Description = "Spotdl server";
        };

        Service.ExecStart = "${lib.getBin pkgs.spotdl}/bin/spotdl web";
        wantedBy = "default.target";
      };

      home.packages = [ pkgs.spotdl ];
    };

  services.navidrome = {
    enable = true;
    openFirewall = true;
    group = "multimedia";
    settings = {
      MusicFolder = "/mnt/storage/Media/music";
    };
  };

  fileSystems."/mnt/storage" = {
    device = "//192.168.0.112/vault";
    fsType = "cifs";
    options = [
      "auto"
      "_netdev"
      "rw"
      "auto"
      "gid=991"
      "dir_mode=0770"
      "file_mode=0770"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/storage/Media 0770 - multimedia - -"
  ];

  environment.systemPackages = [
    pkgs.vim
    pkgs.spotdl
  ];
}
