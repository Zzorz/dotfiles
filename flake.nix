{
  description = "RazYang's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    doom.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager
    , home-manager-unstable, doom, ... }@inputs:
    let
      vars = { stateVersion = "22.11"; };
      makeNixOSModules = { hostname, system }: [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs vars; };
          };
        }
        (./hosts + "/${hostname}" + /configuration.nix)
      ];
      makeNixOSConfiguration = { hostname, system }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = makeNixOSModules { inherit hostname system; };
        };

      makeNixConfiguration = { system }:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          users = builtins.attrNames (pkgs.lib.attrsets.filterAttrs (name: type: type == "directory" && name != "common") (builtins.readDir ./users ));
        in
        pkgs.lib.genAttrs users (user: home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/${user} ];
        });

    in {
      nixosConfigurations = {
        virtual = makeNixOSConfiguration {
          hostname = "virtual";
          system = "x86_64-linux";
        };
        deskmini = makeNixOSConfiguration {
          hostname = "deskmini";
          system = "x86_64-linux";
        };
      };
      homeConfigurations = makeNixConfiguration { system = "x86_64-linux"; };
    };
}
