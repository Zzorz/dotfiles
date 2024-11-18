{
  description = "RazYang's Nix Flake Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    treefmt-nix.url = "https://github.com/numtide/treefmt-nix/archive/746901bb8dba96d154b66492a29f5db0693dbfcc.zip";
    flake-programs-sqlite.url = "github:wamserma/flake-programs-sqlite";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixvim.url = "github:nix-community/nixvim";
    
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    flake-programs-sqlite.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";

  };

  outputs =
    inputs@{ ... }:
    let
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
      ];

      pkgsWithSystem =
        system:
        import inputs.nixpkgs {
          inherit system;
          overlays = inputs.nixpkgs.lib.attrValues inputs.self.overlays;
          config.allowUnfree = true;
        };

      eachSystem = f: inputs.nixpkgs.lib.genAttrs systems (system: f (pkgsWithSystem system));

      treefmtEval = eachSystem (
        pkgs:
        inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.nixfmt.enable = true;
          programs.deno.enable = true;
          programs.gofmt.enable = true;
          programs.rustfmt.enable = true;
          programs.clang-format.enable = true;
        }
      );
    in
    {
      overlays = import ./overlays { inherit inputs; };
      packages = eachSystem (pkgs: (import ./packages { inherit inputs pkgs; }));
      nixosModules = import ./nixos-modules;
      nixosConfigurations = import ./nixos-configurations { inherit inputs; };

      homeModules = import ./home-modules;
      homeConfigurations = import ./home-configurations {
        inherit inputs pkgsWithSystem;
      };

      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
    };

}
