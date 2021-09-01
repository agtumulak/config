# environment variables
export DEV_PATH="/Users/atumulak/Developer"
export SHELL="/bin/zsh" # used by .tmux.conf
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


# aliases
alias ls='ls -FGh'
alias ll='ls -al'
alias vim='nvim'
alias rb='rm -rf build && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug .. && make -j12 && cd ..'
alias cf='/usr/local/miniconda3/envs/canvas-fetch/bin/python ~/Developer/canvas-fetch/canvas-fetch.py'

# grrr.tech/posts/2020/switch-dark-mode-os/
alias lightmode='tmux set-option status-fg white && tmux setenv -g TMUX_THEME light'
alias darkmode='tmux set-option status-fg black && tmux setenv -g TMUX_THEME dark'


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


BASE16_SHELL="${DEV_PATH}/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL/profile_helper.sh")"


# pure prompt: github.com/sindresorhus/pure/wiki
fpath+="${DEV_PATH}/pure"
autoload -U promptinit
promptinit
prompt pure
zstyle ':prompt:pure:prompt:success' color 'green'


# syntax highlighting: github.com/zsh-users/zsh-syntax-highlighting
source "${DEV_PATH}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


