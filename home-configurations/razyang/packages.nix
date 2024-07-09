{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    radare2
    inputs.self.packages.${pkgs.system}.nixvim
  ];
}
