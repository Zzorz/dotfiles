{ inputs, cell }:
let 
  pkgs = import inputs.nixpkgs { inherit (inputs.nixpkgs) system;};
in
{
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
  starship.enable = true;
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
        rev = "v3.8.0";
        sha256 = "c8651cc2bc0b5e9b01de7cc62136e2ff4c9c65e8f4f46be8cc3a2c7047fbaa9e";
      };
    }];
    initExtra = (builtins.readFile ./zshrc);
  };

  atuin.enable = true;
  exa = {
    enable = true;
    enableAliases = true;
  };
  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-visual-multi vim-nix ];
  };

}
