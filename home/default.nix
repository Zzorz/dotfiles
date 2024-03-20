{ stateVersion, pkgs, ... }@args:
{
  imports = [
    (import ./neovim.nix (args))
    #(import ./doom-emacs (args))
  ];
             
  home = {
    inherit stateVersion;
    packages = with pkgs;[
      file
      du-dust
      fd
      vivid
    ];
  };
  programs = {
    pyenv.enable = true;
    git = {
      userName = "RazYang";
      userEmail = "xzzorz@gmail.com";
    };
    home-manager.enable = true;
    zellij ={
      enable = true;
      enableBashIntegration = false;
      settings = {
        pane_frames = false;
        theme = "gruvbox-dark";
        themes = {
          gruvbox-dark = {
            fg = [213 196 161];
            bg = [40 40 40];
            black = [60 56 54];
            red = [204 36 29];
            green = [152 151 26];
            yellow = [215 153 33];
            blue = [69 133 136];
            magenta = [177 98 134];
            cyan = [104 157 106];
            white = [251 241 199];
            orange = [214 93 14];
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
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "emacs";
      antidote = {
        enable = true;
	plugins = [
	  "romkatv/powerlevel10k"
	  "z-shell/zsh-editing-workbench"
	  "sorin-ionescu/prezto path:modules/completion"
	  "hlissner/zsh-autopair kind:defer"
	];
      };
      completionInit = "";
      initExtraFirst = ''
        typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';
      initExtra = ''
        [[ ! -f ~/.cargo/env ]] || source ~/.cargo/env
        [[ ! -f ~/.zsh_extra ]] || source ~/.zsh_extra
	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
	export LS_COLORS="$(vivid generate gruvbox-dark)"
      '';
    };
    #oh-my-posh = {
    #  enable = true;
    #  useTheme = "emodipt-extend";
    #};
    atuin.enable = true;
    navi.enable = true;
    #nix-index.enable = true;
    ripgrep.enable = true;
    broot.enable = true;
    bottom.enable = true;
    #carapace.enable = true;
    helix.enable = true;
    lsd = {
      enable = true;
      enableAliases = true;
    };
  };
}
