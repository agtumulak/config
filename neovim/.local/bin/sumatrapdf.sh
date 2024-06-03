#!/usr/bin/env zsh

# Preprocesses commands for forward and inverse search between neovim and SumatraPDF
# WSL uses Unix style paths while SumatraPDF reader uses UNC style paths. This script:
# - Converts paths passed as arguments to `-forward-search`
# - Converts paths in synctex files when necessary
#
# For inverse search, use the following command in SumatraPDF:
# ```
# wsl.exe --cd ~ ~/.local/share/nvim/mason/bin/texlab inverse-search --input $(wslpath '%f') --line %l
# ````

converted_args=()
for arg in "${@}"; do
    if [[ -f "${arg}" ]]; then
        # assume synctex files are in same directory as PDF
        if [[ ${arg} == *.pdf ]]; then
            # assume that synctex files are uncompressed (-synctex=-1)
            synctex="$(dirname ${arg})/$(basename ${arg} .pdf).synctex"
            if [[ -f  "${synctex}" ]]; then
                # change each instance of a UNIX path to a UNC path using `wslpath`
                # this should skip over paths which are already converted because we assume UNIX style paths begin with '/'
                sed -i -E 's/^(Input:[0-9]+:)(\/.*)/printf "%s%s\n" "\1" "$(wslpath -w \2)"/e' ${synctex}
            fi
        fi
        # convert PDF and TeX filepaths to UNC
        arg="$(wslpath -w ${arg})"
    fi
    converted_args+="${arg}"
done

/mnt/c/Users/atumu/AppData/Local/SumatraPDF/SumatraPDF.exe ${converted_args}
powershell.exe -Command "Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class Win32 { [DllImport(\"user32.dll\")] public static extern bool SetForegroundWindow(IntPtr hWnd); }'; \$h = (Get-Process WindowsTerminal | Select-Object -Last 1).MainWindowHandle; [Win32]::SetForegroundWindow(\$h)"
