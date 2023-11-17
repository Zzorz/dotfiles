{ self, inputs, stateVersion, pkgs, ... }:
let
  hostProfiles = builtins.attrNames (pkgs.lib.attrsets.filterAttrs (name: type: type == "directory") (builtins.readDir ./. ));
in
{
  flake = {
    nixosConfigurations = pkgs.lib.genAttrs hostProfiles (host:
      inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ./${host}
      ];
      specialArgs = { inherit inputs stateVersion pkgs; };
    });
  };
}
