{ lib, inputs, config, ... }:

{
  nix = {
    # Use the same nixpkgs for nix flake commands 
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Use the same nixpkgs for nix non flake commands 
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
      trusted-substituters = [ "https://devenv.cachix.org" ];
    };

    # Enable auto garbage collecting 
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
