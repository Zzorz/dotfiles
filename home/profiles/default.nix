{ self, inputs, ... }:
let
  pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
in
{
  flake = {
    homeConfigurations.yangtiangang = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./yangtiangang
      ];
    };
  };
}
