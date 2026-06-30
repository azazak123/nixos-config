{ config, lib, pkgs, ... }:
{
  users.users.azazak123 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ/KzrtIe6d3BSGde2vCmhNDrC2B531cjwywiBQ6hf3c"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPBSMGgGLid5V7qd9U7gYXmsSZ1QvHs911hVxvdBk51A relay"
    ];
  };

  users.groups.multimedia = { };
}
