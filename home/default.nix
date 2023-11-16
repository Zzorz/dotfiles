{ inputs, stateVersion, pkgs, ... }:
let 
  #pkgs = import inputs.nixpkgs { inherit system };
in
{
  home = {
    inherit stateVersion;
  };
  programs = {
    git = {
      userName = "RazYang";
      userEmail = "xzzorz@gmail.com";
    };
      home-manager.enable = true;
    tmux = {
      enable = true;
      plugins = with pkgs; [ tmuxPlugins.nord ];
      extraConfig = (builtins.readFile ./tmux.conf);
    };
    #starship.enable = true;
    zoxide = { enable = true; enableZshIntegration = true; };
    fzf = { enable = true; enableZshIntegration = true; };
    zsh = {
      enable = true;
      completionInit = "";
      plugins = [{
        name = "zinit";
        file = "zinit.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "zinit";
          rev = "v3.12.0";
          sha256 = "02260ad694450f8086bc171083d4308058dce59e7ae13565596d0ccf1a317565";
        };
      }];
      initExtra = (builtins.readFile ./zshrc);
    };

    atuin.enable = true;
    eza = {
      enable = true;
      enableAliases = true;
    };
    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ vim-visual-multi vim-nix ];
    };
  };

}
