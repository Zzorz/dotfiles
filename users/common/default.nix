{pkgs, config, stateVersion, ...}:
{
  imports = [
    ./shell.nix
  ];
  home.stateVersion = stateVersion;
  programs.home-manager.enable = true;
}
