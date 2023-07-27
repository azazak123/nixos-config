{
  description = "A very basic flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager
    home-manager =
      {
        url = "github:nix-community/home-manager/release-23.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

    # VS Code extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgsUnstable";
    };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, hyprland, nix-vscode-extensions, home-manager }@inputs:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsUnstable = import nixpkgsUnstable {
        inherit system;
        config.allowUnfree = true;
      };
      vscodeExt = nix-vscode-extensions.extensions.${system};
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit pkgsUnstable vscodeExt hyprland inputs; };
        modules = [
          hyprland.nixosModules.default
          ./modules/configuration.nix
          home-manager.nixosModules.home-manager
          ./modules/home.nix
        ];
      };

      devShell.${system} = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixpkgs-fmt
          nil
        ];
      };

      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
