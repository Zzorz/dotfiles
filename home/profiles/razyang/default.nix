{inputs, ... }@args:
{
  imports = [
    (import ../../. (args))
  ];
  home = {
    username = "razyang";
    homeDirectory = "/home/razyang";
  };
}
