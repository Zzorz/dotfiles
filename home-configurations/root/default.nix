{ inputs, ... }:
{

  system = "x86_64-linux";
  modules = with inputs; [
    self.homeModules.standalone
    {
      home = {
        homeDirectory = "/root";
        stateVersion = "24.05";
      };
    }
  ];

}
