{
  description = "A very basic flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # VS Code extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Doom emacs
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nix-vscode-extensions,
      home-manager,
      nix-doom-emacs-unstraightened,
    }@inputs:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            tlp = pkgs-unstable.tlp;
          })
        ];
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      vscodeExt = nix-vscode-extensions.extensions.${system};
    in
    {
      nixosConfigurations.tomo = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit pkgs-unstable vscodeExt inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/tomo/configuration.nix
        ];
      };

      nixosConfigurations.osaka-jellyfin = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit pkgs-unstable vscodeExt inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/osaka/jellyfin.nix
        ];
      };

      nixosConfigurations.osaka-nginx = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit pkgs-unstable vscodeExt inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/osaka/nginx.nix
        ];
      };

      nixosConfigurations.osaka-servarr = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit pkgs-unstable vscodeExt inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/osaka/servarr.nix
        ];
      };

      nixosConfigurations.osaka-navidrome = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit pkgs-unstable vscodeExt inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/osaka/navidrome.nix
        ];
      };

      devShell.${system} = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixfmt-rfc-style
          nil
        ];
      };

      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
