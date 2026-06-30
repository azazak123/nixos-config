{ ... }:
{
  imports = [
    ./openssh.nix
    ./nginx.nix
    ./network-storage.nix
    ./media.nix
    ./klipper.nix
    ./tlp.nix
    ./acme.nix
    ./kavita.nix
  ];
}
