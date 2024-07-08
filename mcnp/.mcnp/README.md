# MCNP Snippets

## Requirements
- Visual Studio Code Extensions, `vsce`, for packaging extensions. Three options:
    1. Skip this step since `mcnp-snippets-0.1.0.vsix` is already included in this repo
    2. Install via Node.js:
    ```
    npm install -g @vscode/vsce
    ```
    3. Install via Homebrew:
    ```
    brew install vsce
    ```
- Visual Studio Code executable, `code`, for installing extensions locally
    1. In VS Code, open the Command Palette (<kbd>⌘</kbd> <kbd>Shift</kbd> <kbd>P</kbd> on MacOS)
    2. Type `shell command` to execute `Shell Command: Install 'code' command in PATH`

## Contributing

- Modify snippets in `./snippets/mcnp.json`. Syntax for snippets is [quite simple](https://code.visualstudio.com/docs/editor/userdefinedsnippets#_snippet-syntax).
- Add filetypes you wish to associate with MCNP under "contributes/language/extensions" in `package.json`

## Installing

1. Package extension into `*.vsix` file. Ignore all warnings.
    ```
    vsce package
    ```
2. Install extension locally
    ```
    code --install-extension mcnp-snippets-0.1.0.vsix
    ```
3. Verify extension is installed in Code > Settings > Extensions

## Usage
Open a file with a `.mcnp` extension. Type `mcnp` to get started. Some autocompleted cards are `cell`, `surface`, `material`, and `kcode`
