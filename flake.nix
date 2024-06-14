{
  description = "RazYang's NixOS Flake";

  inputs = {
    nixpkgs = {
      url = "git+https://mirrors.cernet.edu.cn/nixpkgs.git?submodules=1&shallow=1&ref=nixos-unstable";
    };

    home-manager = {
      url = "git+https://github.com/nix-community/home-manager?submodules=1&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-lib = {
      url = "git+https://mirrors.cernet.edu.cn/nixpkgs.git?submodules=1&shallow=1&ref=nixos-unstable&dir=lib";
    };

    flakelight = {
      url = "git+https://github.com/nix-community/flakelight?submodules=1&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "git+https://github.com/LnL7/nix-darwin?submodules=1&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "git+https://github.com/nix-community/nix-index-database?submodules=1&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flakelight-darwin = {
      url = "git+https://github.com/cmacrae/flakelight-darwin?submodules=1&shallow=1";
      inputs.flakelight.follows = "flakelight";
      inputs.nix-darwin.follows = "nix-darwin";
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
        darwinConfigurations = [ "darwin-configurations" ];
        bundlers = [ "bundlers" ];
      };
    });
}
