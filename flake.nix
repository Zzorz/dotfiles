{
  description = "RazYang's NixOS Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    #nix-doom-emacs = {
    #  url = "github:nix-community/nix-doom-emacs";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #}

  };

  nixConfig = {
    #extra-experimental-features = "nix-command flakes";
    #substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs;} {
    systems = ["x86_64-linux"];
    imports = [
      {
        _module.args = rec {
          stateVersion = "23.11";
          system = "x86_64-linux";
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            #config.contentAddressedByDefault = true;
          };
        };
      }
      ./home/profiles
      ./hosts/profiles
    ];
  };
}
