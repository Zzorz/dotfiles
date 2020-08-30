source $HOME/.zsh/starship.zsh
source $HOME/.zsh/zsh-defer/zsh-defer.plugin.zsh

##################################################################################
#	PLUGIN MANAGER
##################################################################################
source "$HOME/.zinit/bin/zinit.zsh"
zsh-defer autoload -Uz _zinit && (( ${+_comps} )) && _comps[zinit]=_zinit

zsh-defer zinit light-mode wait silent for \
	psprint/zsh-editing-workbench \
	zdharma/fast-syntax-highlighting \
	hlissner/zsh-autopair \
	davidparsson/zsh-pyenv-lazy \
	chrissicool/zsh-256color \
	romkatv/zsh-prompt-benchmark \
	atload'_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
	atload'_zsh_autosuggest_start' zpm-zsh/colorize \
	atload'export AUTO_NOTIFY_THRESHOLD=60;\
			export AUTO_NOTIFY_EXPIRE_TIME=100;' MichaelAquilina/zsh-auto-notify

zsh-defer zinit wait silent is-snippet for \
	OMZ::lib/key-bindings.zsh \
	OMZ::plugins/urltools/urltools.plugin.zsh \
	PZT::modules/completion/init.zsh \
	/usr/share/fzf/completion.zsh \
	atload'bindkey -r "^[c";bindkey -r "^T"' /usr/share/fzf/key-bindings.zsh \
	$HOME/.zsh/dir_colors.zsh \
	$HOME/.zsh/fasd.zsh
	#/usr/share/zsh/site-functions/_docker

##################################################################################
#	ENVIRONMENTS VARIABLES
##################################################################################
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:~/.gem/ruby/2.7.0/bin/
export PATH=$HOME/.local/bin:$PATH
#export LD_LIBRARY_PATH=$HOME/.local/lib
#export C_INCLUDE_PATH=$HOME/.local/include
#export CPLUS_INCLUDE_PATH=$HOME/.local/include
#export PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig
export EDITOR=nvim
export ALTERNATE_EDITOR=""

##################################################################################
#	ALIASES
##################################################################################
alias search-package='pacman -Slq | fzf -m --bind "ctrl-j:accept,ctrl-k:kill-line" --reverse --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'
alias owf='tmux new-window nnn'
alias osf='tmux split-window nnn'
alias open='xdg-open'
alias j='fasd_cd -d'
alias gfw='proxychains -q -f ~/.gfw_proxy'
alias proxy='export all_proxy="http://127.0.0.1:1081";'
alias ls='exa -FG'
alias mkdir='mkdir -p'
alias gdb='gdb -q'
alias asm='cgasm'
alias wdiff="wdiff -n -w $'\033[30;41m' -x $'\033[0m'   -y $'\033[30;42m' -z $'\033[0m'"

##################################################################################
#	FUNCTIONS
##################################################################################

help(){
    curl cheat.sh/$1
}

chlib(){
	patchelf --set-interpreter $HOME/.glibc/$1/ld-$1.so --set-rpath $HOME/.glibc/$1 $2
	
}

##################################################################################
#	HISTORY CONFIG
##################################################################################
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
export HISTSIZE=9999999
export SAVEHIST=9999999
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt interactivecomments

##################################################################################
#	MISC CONFIG
##################################################################################

export FZF_CTRL_T_OPTS="--height 50% --preview '(bat --theme=TwoDark --style=numbers --color=always {} | head -n 500)' --bind 'ctrl-j:accept,ctrl-k:kill-line' --reverse"
export FZF_ALT_C_OPTS="--height 50% --preview 'tree -C {} | head -200' --bind 'ctrl-j:accept,ctrl-k:kill-line' --reverse"
export FZF_CTRL_R_OPTS="--height 50% --preview 'echo {}' --preview-window down:3:hidden:wrap --bind 'ctrl-j:accept,ctrl-k:kill-line' --reverse"

zsh_stats () {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

##################################################################################
#	DO NOT TOUCH IT !!!
##################################################################################
