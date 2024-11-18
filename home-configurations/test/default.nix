{ inputs, ... }:
{

  system = "x86_64-linux";
  modules = with inputs; [
    self.homeModules.standalone
    {
      home = {
        stateVersion = "24.05";
      };
    }
  ];

}
