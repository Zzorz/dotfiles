{ inputs, ... }:
{
  system = "x86_64-linux";
  modules = [
    inputs.self.homeModules.standalone
    ./packages.nix
    { home = { stateVersion = "24.05"; }; }
  ];
}
