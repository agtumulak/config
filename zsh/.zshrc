# enable homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# enable fzf
eval "$(fzf --zsh)"

# https://python-poetry.org/docs/#zsh
fpath=(~/.zfunc $fpath)
path=(/home/atumulak/.local/bin $path)

## zsh

# https://unix.stackexchange.com/a/389883
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt auto_pushd

# antidote
source /home/linuxbrew/.linuxbrew/opt/antidote/share/antidote/antidote.zsh
antidote load # loads .zsh_plugins.txt

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

# https://github.com/sharkdp/bat
alias cat='bat --theme base16-256'
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

## keybindings

bindkey -v # https://stackoverflow.com/a/58188295
bindkey '^?' backward-delete-char # https://superuser.com/a/533685

## system specific

# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#environment-setup
path=(/usr/local/cuda/bin $path)
typeset -T -gxU LD_LIBRARY_PATH ld_library_path
ld_library_path=(/usr/local/cuda/lib64)
