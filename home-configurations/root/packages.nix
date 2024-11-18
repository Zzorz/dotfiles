{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    gdu
    git
    htop
    file
    binutils
    inputs.self.packages.${pkgs.system}.nixvim
  ];
}
