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

    flake-parts = {
      url = "git+https://github.com/hercules-ci/flake-parts?submodules=1&shallow=1";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
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
