{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    radare2
    taskwarrior
  ];
}
