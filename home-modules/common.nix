{ pkgs, inputs, ... }:
{
  imports = with inputs.self.homeModules; [ zsh neovim ];
  programs = {
    pyenv.enable = true;
    git = {
      userName = "RazYang";
      userEmail = "xzzorz@gmail.com";
    };
    home-manager.enable = true;
    zellij = {
      enable = true;
      enableBashIntegration = false;
      settings = {
        pane_frames = false;
        theme = "gruvbox-dark";
        themes = {
          gruvbox-dark = {
            fg = [ 213 196 161 ];
            bg = [ 40 40 40 ];
            black = [ 60 56 54 ];
            red = [ 204 36 29 ];
            green = [ 152 151 26 ];
            yellow = [ 215 153 33 ];
            blue = [ 69 133 136 ];
            magenta = [ 177 98 134 ];
            cyan = [ 104 157 106 ];
            white = [ 251 241 199 ];
            orange = [ 214 93 14 ];
          };
        };
      };
    };
    tmux = {
      enable = true;
      plugins = with pkgs; [
        tmuxPlugins.gruvbox
      ];
      extraConfig = (builtins.readFile ./tmux.conf);
    };
    #starship.enable = true;
    zoxide = { enable = true; enableZshIntegration = true; };
    fzf = { enable = true; enableZshIntegration = true; };
    atuin.enable = true;
    navi.enable = true;
    #nix-index.enable = true;
    ripgrep.enable = true;
    broot.enable = true;
    bottom.enable = true;
    helix.enable = true;
    lsd = {
      enable = true;
      enableAliases = true;
    };
  };
}
