{
  pkgs,
  modulesPath,
  inputs,
  lib,
  config,
  ...
}:

let
  programs = ../../programs;
in

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  networking.hostName = "osaka-servarr";

  users.groups.multimedia = { };

  nix = import /${programs}/nix-config.nix { inherit inputs lib config; };

  fileSystems."/mnt/storage" = {
    device = "//192.168.0.112/vault";
    fsType = "cifs";
    options = [
      "_netdev"
      "rw"
      "auto"
      "gid=995"
      "dir_mode=0770"
      "file_mode=0770"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/storage/Media 0770 - multimedia - -"
  ];

  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "multimedia";
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };
  services.transmission = {
    enable = true;
    group = "multimedia";
    home = "/mnt/storage/Media/Downloads/Vova";
    settings = {
      download-dir = "${config.services.transmission.home}/Downloads";
    };
  };
  systemd.services.transmission.serviceConfig.Restart = "always";
  systemd.services.transmission.serviceConfig.RestartSec = 30;

  services.openssh.enable = true;
  services.getty.autologinUser = "root";

  environment.systemPackages = [
    pkgs.vim
  ];

  programs.fish.enable = true;

  system.stateVersion = "24.05";
}
