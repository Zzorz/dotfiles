{ stateVersion, pkgs, ... }@args:
{
  imports = [
    (import ./neovim.nix (args))
  ];
             
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
      plugins = with pkgs; [
        tmuxPlugins.nord 
      ];
      extraConfig = (builtins.readFile ./tmux.conf);
    };
    #starship.enable = true;
    zoxide = { enable = true; enableZshIntegration = true; };
    fzf = { enable = true; enableZshIntegration = true; };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      defaultKeymap = "emacs";
      antidote = {
        enable = true;
	plugins = [
	  "zdharma-continuum/fast-syntax-highlighting"
	  "sorin-ionescu/prezto path:modules/completion kind:defer"
	  "hlissner/zsh-autopair kind:defer"
	  "ael-code/zsh-colored-man-pages kind:defer"
	];
      };
      completionInit = "";
      initExtra = ''
        [[ ! -f "$HOME/.cargo/env" ]] || source "$HOME/.cargo/env"
      '';
    };
    oh-my-posh = {
      enable = true;
      useTheme = "emodipt-extend";
    };
    atuin.enable = true;
    navi.enable = true;
    #nix-index.enable = true;
    ripgrep.enable = true;
    broot.enable = true;
    bottom.enable = true;
    #carapace.enable = true;
    #helix.enable = true;
    lsd = {
      enable = true;
      enableAliases = true;
    };
  };
}
