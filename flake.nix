{
  description = "RazYang's NixOS Flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
	impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { ... }@inputs:
    inputs.flakelight ./. ({ lib, ... }: {
      inherit inputs;
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      nixDir = ./.;
      nixpkgs.config = {
        allowUnfree = true;
      };
      withOverlays = [
        inputs.emacs-overlay.overlays.default
      ];
      nixDirAliases = {
        packages = [ "packages" ];
        devShells = [ "dev-shells" ];
        homeModules = [ "home-modules" ];
        nixosModules = [ "nixos-modules" ];
        homeConfigurations = [ "home-configurations" ];
        nixosConfigurations = [ "nixos-configurations" ];
        bundlers = [ "bundlers" ];
      };
    });
}
