# Config
Intended for use with [stow][1]

```console
$ stow --dir=path/to/repo --target=${HOME} tmux vim
```

# Dependencies
The following repositories must be found under `DEV_PATH` (referenced in `.zshrc`): [pure], [conda-zsh-completion], and [zsh-syntax-highlighting]. For pure to work, it must be [installed manually](https://github.com/sindresorhus/pure#example).


[1]: http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
[pure]: https://github.com/sindresorhus/pure
[conda-zsh-completion]: https://github.com/esc/conda-zsh-completion
[zsh-syntax-highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting
