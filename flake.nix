{
  description = "RazYang's NixOS Flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flakelight = {
      url = "git+https://github.com/nix-community/flakelight?submodules=1&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "git+https://github.com/wamserma/flake-programs-sqlite?submodules=1&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "git+https://github.com/nix-community/nix-index-database?submodules=1&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { flakelight, ... }@inputs:
    flakelight ./. ({ lib, ... }: {
      inherit inputs;
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      nixDir = ./.;
      nixpkgs.config = {
        allowUnfree = true;
      };
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
