{pkgs, config, ...}:
{
  imports = [
    ./shell.nix
  ];
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    ripgrep
    nixfmt
    fd
    nix-index
    ncdu
    dig
    bottom
    gef
    file
    iperf3
    zsh
    vim
    tmux
    jq
    git
    zoxide
  ];
  programs.home-manager.enable = true;
}
