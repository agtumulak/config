## system specific

# spack
source /Users/atumulak/Developer/spack/share/spack/setup-env.sh

# mcnp
export DATAPATH=/Users/atumulak/Developer/ndatk-data
export path=("/Users/atumulak/Developer/MCNP/mcnp6-v6.3.1/build-gcc-15" $path)

# enable fzf
# https://github.com/junegunn/fzf/issues/3528
export FZF_CTRL_R_OPTS='--bind "esc:become:echo {q}"'
eval "$(fzf --zsh)"

# https://ghostty.org/docs/features/shell-integration
if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

## zsh

# https://unix.stackexchange.com/a/389883
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt auto_pushd

# antidote
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load # loads .zsh_plugins.txt

# poetry
fpath+=~/.zfunc

# tab completion style
zstyle ':completion:*' menu select
zstyle ':completion:*' file-list all
# https://unix.stackexchange.com/a/323282
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# https://github.com/mattmc3/antidote/discussions/74
autoload -Uz compinit && compinit -u

# https://github.com/chriskempson/base16-shell#if-youre-using-zsh--plug
[[ -z BASE16_THEME ]] && base16_gruvbox-dark-hard

## environment variables

export MANPAGER='nvim +Man!' # https://neovim.io/doc/user/filetype.html#ft-man-plugin

## aliases

alias diff='delta'
alias less='less -R' # https://spack.readthedocs.io/en/latest/basic_usage.html#basic-usage
alias ls='ls --color=auto' # color
alias ll='ls -al' # long
alias tmux='tmux -u' # https://github.com/jeffreytse/zsh-vi-mode
alias vim='nvim'
alias syncrl='xclip -o -select clipboard | pbcopy'
alias synclr='pbpaste | xclip -i -select clipboard'

# https://github.com/sharkdp/bat
alias cat='bat --theme base16-256'
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

## keybindings

bindkey -v # https://stackoverflow.com/a/58188295
bindkey '^?' backward-delete-char # https://superuser.com/a/533685
