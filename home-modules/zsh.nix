{ pkgs, ... }:
{
  programs.zsh = {
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
        "ael-code/zsh-colored-man-pages"
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
      #export LS_COLORS="$(vivid generate gruvbox-dark)"
    '';
  };
}