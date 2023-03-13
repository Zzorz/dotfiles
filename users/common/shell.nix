{ pkgs, inputs, ... }: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [ tmuxPlugins.nord ];
    extraConfig = (builtins.readFile ./config/tmux.conf);
  };
  programs.starship.enable = true;
  programs.zoxide = { enable = true; enableZshIntegration = true; };
  programs.zsh = {
    enable = true;
    plugins = [{
      name = "zinit";
      file = "zinit.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "zdharma-continuum";
        repo = "zinit";
        rev = "v3.8.0";
        sha256 =
          "c8651cc2bc0b5e9b01de7cc62136e2ff4c9c65e8f4f46be8cc3a2c7047fbaa9e";
      };
    }];
    initExtra = (builtins.readFile ./config/zshrc);
  };
  programs.fzf.enable = true;
}
