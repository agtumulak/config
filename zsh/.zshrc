# environment variables
export DEV_PATH="/Users/atumulak/Developer"
export SHELL="/usr/local/bin/zsh"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"


# zsh
setopt appendhistory beep extendedglob nomatch
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

bindkey -v # vim keybindings
bindkey '^_' undo # can undo expansions
bindkey '^?' backward-delete-char # superuser.com/a/533685
bindkey '^R' history-incremental-search-backward # stackoverflow.com/q/3127392


# anaconda
source /usr/local/miniconda3/etc/profile.d/conda.sh


# aliases
alias ls='ls -FGh'
alias ll='ls -al'
alias vim='nvim'


# compsys: zsh.sourceforge.net/Guide/zshguide06.html
setopt COMPLETE_IN_WORD MAGIC_EQUAL_SUBST
zstyle ':completion:*' add-space true
zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # github.com/robbyrussell/oh-my-zsh/issues/1563
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu 'select'
zstyle ':completion:*' format 'completing: %d'
zstyle ':completion:*' list-prompt '%S%l: hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%Sscrolling: %l%s'
zstyle ':completion:*' auto-description 'specify: %d'

fpath+="${DEV_PATH}/conda-zsh-completion"
autoload -Uz compinit
compinit


# pure prompt: github.com/sindresorhus/pure/wiki
fpath+="${DEV_PATH}/pure"
autoload -U promptinit
promptinit
prompt pure
PROMPT='%}%(12V.%F{242}%12v%f .)%(?.%F{green}.%F{red})${PURE_PROMPT_SYMBOL:-❯}%f '
RPROMPT='${CONDA_PROMPT_MODIFIER}'


# syntax highlighting: github.com/zsh-users/zsh-syntax-highlighting
source "${DEV_PATH}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# tmux: stackoverflow.com/a/13060475
if [ "$TMUX" = "" ]; then
    exec tmux attach-session
else
    export PATH="$PATH"
fi
