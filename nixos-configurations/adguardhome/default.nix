{ inputs, ... }:
{
  system = "x86_64-linux";
  specialArgs = {
    inherit inputs;
    stateVersion = "24.05";
  };
  modules = with inputs;[
    inputs.self.nixosModules.common
    home-manager.nixosModules.home-manager
    ./configuration.nix
  ];
}
