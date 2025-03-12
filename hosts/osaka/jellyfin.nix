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

  networking.hostName = "osaka-jellyfin";

  nix = import /${programs}/nix-config.nix { inherit inputs lib config; };

  users.groups.multimedia = { };

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

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  services.jellyseerr = {
    enable = true;
    openFirewall = true;
  };

  users.users.jellyfin.extraGroups = [
    "input"
    "video"
    "multimedia"
  ];
  users.groups.lxc-render = {
    gid = 104;
    members = [ "jellyfin" ];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      intel-compute-runtime
      intel-media-sdk
    ];
  };

  services.openssh.enable = true;
  services.getty.autologinUser = "root";

  environment.systemPackages = [
    pkgs.vim
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
    pkgs.neofetch
    pkgs.ncdu
  ];

  programs.fish.enable = true;

  programs.git.enable = true;

  system.stateVersion = "24.05";
}
