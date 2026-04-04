{ lib, ... }:

{
  services.flatpak.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  # https://github.com/NixOS/nixpkgs/issues/414135 
  security.lsm = lib.mkForce [ ];
}
