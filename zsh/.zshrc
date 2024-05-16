## system specific

# https://ddw-confluence.lanl.gov/display/ADXComputing/Modules
source /opt/local/packages/Modules/default/init/zsh
module use /opt/local/packages/Modules/5.1.1/modulefiles/debugger

# load spack and base environment
source /local/atumulak/spack/share/spack/setup-env.sh
source /local/atumulak/spack/var/spack/environments/base/loads

# enable fzf
eval "$(fzf --zsh)"

# https://ddw-confluence.lanl.gov/pages/viewpage.action?pageId=543752231
source /home/xshares/PROJECTS/mcatk/modules/setup_mcatk_modules.sh
# ADX modules were reorganized. This flattens the search paths.
module use /opt/local/packages/Modules/default/modulefiles/compiler
module use /opt/local/packages/Modules/default/modulefiles/compiler-gcc
module use /opt/local/packages/Modules/default/modulefiles/mpi
module use /opt/local/packages/Modules/default/modulefiles/tools

# node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm use v16.20.2

# # load spack-environment modules
# source /home/atumulak/Developer/spack-environments/modules/setup_mcatk_modules.sh

# https://ddw-confluence.lanl.gov/display/MCPUB/MCNP+Use+on+HPC+and+ADX+LAN
module use /opt/local/codes/mcnp/modules

# https://unix.stackexchange.com/a/414434
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

## zsh

# https://unix.stackexchange.com/a/389883
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt auto_pushd

# antidote
source /home/atumulak/.antidote/antidote.zsh
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
unset MANPATH

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

# you must run `spack env activate base` to use conda

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/local/atumulak/spack/opt/spack/linux-rhel7-cascadelake/gcc-11.2.0/miniconda3-22.11.1-sarjmvkb5jbireit7ejgvp3eq6uy75gq/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/local/atumulak/spack/opt/spack/linux-rhel7-cascadelake/gcc-11.2.0/miniconda3-22.11.1-sarjmvkb5jbireit7ejgvp3eq6uy75gq/etc/profile.d/conda.sh" ]; then
        . "/local/atumulak/spack/opt/spack/linux-rhel7-cascadelake/gcc-11.2.0/miniconda3-22.11.1-sarjmvkb5jbireit7ejgvp3eq6uy75gq/etc/profile.d/conda.sh"
    else
        export PATH="/local/atumulak/spack/opt/spack/linux-rhel7-cascadelake/gcc-11.2.0/miniconda3-22.11.1-sarjmvkb5jbireit7ejgvp3eq6uy75gq/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
