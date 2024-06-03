{ inputs, ... }:
{
  system = "aarch64-darwin"
    specialArgs = {
  inherit inputs;
  stateVersion = "5";
}
  modules = with inputs; [
home-manager.darwinModules.home-manager
./configuration.nix
];
}
