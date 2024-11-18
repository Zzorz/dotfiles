{
  inputs,
  pkgs,
  static ? false,
}:
if static then pkgs.pkgsStatic.hello else inputs.self.packages.${pkgs.system}.hello
