{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    gdu
    htop
    bottom
    inputs.self.packages.${pkgs.system}.nixvim
  ];
}
