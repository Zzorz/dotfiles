{ inputs, ... }:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = with inputs; [
    self.nixosModules.common
    home-manager.nixosModules.home-manager
    impermanence.nixosModules.impermanence
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
