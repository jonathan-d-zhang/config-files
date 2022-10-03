set -x RIPGREP_CONFIG_PATH "$HOME/.config/.ripgreprc"
set -x FZF_DEFAULT_COMMAND 'rg --files'
status is-interactive; and pyenv init --path | source
pyenv init - | source
starship init fish | source

# pnpm
set -gx PNPM_HOME "/home/jonathan/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
# Created by `pipx` on 2022-09-29 19:53:45
set PATH $PATH /home/jonathan/.local/bin
