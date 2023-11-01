{
  description = "RazYang's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";#"git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git";#github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      stateVersion = "23.05";
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      pkgs = { system }: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      makeNixOSConfiguration = { system }:
        let 
          hostnames = builtins.attrNames (pkgs.lib.attrsets.filterAttrs (name: type: type == "directory" ) (builtins.readDir ./hosts ));
        in
        pkgs.lib.genAttrs hostnames (hostname: nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs stateVersion; };
          modules = [ ./hosts/${hostname}/configuration.nix ];
        });

      makeNixConfiguration = { pkgs, stateVersion, ...}:
        let
          users = builtins.attrNames (pkgs.lib.attrsets.filterAttrs (name: type: type == "directory" && name != "common") (builtins.readDir ./users ));
        in
        pkgs.lib.genAttrs users (user: home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/${user} ];
          extraSpecialArgs = { inherit inputs stateVersion; };
        });

    in 
    {
      nixosConfigurations = forAllSystems (system: {
          lxc = makeNixOSConfiguration {
            hostname = "lxc";
            inherit system;
          };
          virtual = makeNixOSConfiguration {
            hostname = "virtual";
            inherit system;
          };
          deskmini = makeNixOSConfiguration {
            hostname = "deskmini";
            inherit system;
          };
      });
      packages = forAllSystems (system: {
        homeConfigurations = makeNixConfiguration { pkgs = pkgs { inherit system; }; inherit stateVersion; };
      });
    };
}
