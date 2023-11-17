{inputs, ... }@args:
{
  imports = [
    (import ../../. (args))
  ];
  home = {
    username = "root";
    homeDirectory = "/root";
  };
}
