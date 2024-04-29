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

  };

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    extra-substituters = [ "https://mirrors.cernet.edu.cn/nix-channels/store" "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    auto-optimise-store = true;
  };

  outputs = { flakelight, ... }@inputs:
    flakelight ./. {
      inherit inputs;
      nixDir = ./.;
      nixDirAliases = {
        homeModules = [ "home-modules" ];
        nixosModules = [ "nixos-modules" ];
        homeConfigurations = [ "home-configurations" ];
        nixosConfigurations = [ "nixos-configurations" ];
      };
    };
}
