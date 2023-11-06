{
  description = "RazYang's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nix-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  };

  inputs = {
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        stable.follows = "nixpkgs";
      };
    };
    nixago = { url = "github:nix-community/nixago"; inputs.nixpkgs.follows = "nixpkgs"; };
    hive = { 
      url = "github:divnix/hive";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixago.follows = "nixago";
        colmena.follows = "colmena";
      };
    };
    haumea.follows = "hive/std/haumea";
    std.follows = "hive/std";
    devshell = { url = "github:numtide/devshell"; inputs.nixpkgs.follows = "nixpkgs"; };
  };
  inputs = {
    incl = { url = "github:divnix/incl"; inputs.nixlib.follows = "nixpkgs"; };
  };

  outputs = { self, hive, std, incl, ... } @ inputs: std.growOn {
    inherit inputs;
    nixpkgsConfig = { allowUnfree = true; };
    systems = [ "x86_64-linux" ];
    cellsFrom = ./cells;
    cellBlocks = with std.blockTypes // hive.blockTypes; [
      #nixosConfigurations 
      homeConfigurations 
      (functions "homeProfiles")
    ];
  } {
     #nixosConfigurations = hive.collect self "nixosConfigurations";
     homeConfigurations = hive.collect self "homeConfigurations";
  };
}
