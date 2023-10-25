{
  description = "RazYang's NixOS Flake";

  inputs = {
    nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      vars = { stateVersion = "23.11"; };
      makeNixOSModules = { hostname, system }: [
        { nixpkgs.config.allowUnfree = true; }
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
          };
        }
        (./hosts + "/${hostname}" + /configuration.nix ) { }
      ];
      makeNixOSConfiguration = { hostname, system }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = makeNixOSModules { inherit hostname system; };
        };

      makeNixConfiguration = { system }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          users = builtins.attrNames (pkgs.lib.attrsets.filterAttrs (name: type: type == "directory" && name != "common") (builtins.readDir ./users ));
        in
        pkgs.lib.genAttrs users (user: home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./users/${user} 
          ];
        });

    in {
      nixosConfigurations = {
        lxc = makeNixOSConfiguration {
          hostname = "lxc";
          system = "x86_64-linux";
        };
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
