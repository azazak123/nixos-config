{ config, lib, pkgs, ... }:
{
  virtualisation.oci-containers.containers = {
    wishlist = {
      image = "ghcr.io/cmintey/wishlist:latest";
      ports = ["3280:3280"];
      volumes = [
        "/home/azazak123/containers/wishlist/uploads:/usr/src/app/uploads"
        "/home/azazak123/containers/wishlist/data:/usr/src/app/data"
      ];
      environment = {
        ORIGIN = "https://wishlist.azazak123.dedyn.io";
        DEFAULT_CURRENCY = "UAH";
      };
    };
  };
}
