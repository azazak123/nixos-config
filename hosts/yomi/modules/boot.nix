{ config, lib, pkgs, ... }:
{
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.grub.mirroredBoots = [
    {
      devices = [ "/dev/disk/by-uuid/5141-69CA" ];
      path = "/boot-fallback";
    }
  ];
}
