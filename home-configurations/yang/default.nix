{ inputs, ... }:
{
  system = "aarch64-darwin";
  modules = [
    inputs.self.homeModules.standalone
    ./packages.nix
    {
      home = {
        stateVersion = "24.05";
        homeDirectory = "/Users/yang";
      };
    }
  ];
}
