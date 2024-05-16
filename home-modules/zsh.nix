{ pkgs, ... }:
{
  programs.carapace.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    prezto = {
      enable = true;
      prompt.theme = "powerlevel10k";
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
      autoload -Uz compinit && compinit
    '';
    initExtra = ''
      [[ ! -f ~/.cargo/env ]] || source ~/.cargo/env
      [[ ! -f ~/.zsh_extra ]] || source ~/.zsh_extra
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      #export LS_COLORS="$(vivid generate gruvbox-dark)"
    '';
  };
}
