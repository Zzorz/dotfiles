{ self, inputs, stateVersion,pkgs, ... }:
let
  #pkgs = import inputs.nixpkgs { system = "x86_64-linux";};
  userProfiles = builtins.attrNames (pkgs.lib.attrsets.filterAttrs (name: type: type == "directory") (builtins.readDir ./. ));
in
{
  flake = {
    homeConfigurations = pkgs.lib.genAttrs userProfiles (user:
      inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./${user}
      ];
      extraSpecialArgs = { inherit inputs stateVersion; };
    });
  };
}
