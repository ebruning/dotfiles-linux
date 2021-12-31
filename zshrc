autoload -Uz compinit vcs_info && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/.rbenv/bin:$HOME/.local/bin:$PATH"
export EDITOR=nvim

[ -f /usr/bin/nvim ] && alias vi=nvim
[ -f /usr/bin/exa ] && alias ls="exa -bl --git --icons --time-style long-iso --group-directories-first"
[ -f /usr/bin/bat ] && alias cat=bat
alias f=ranger
#alias mkdir="ptMkdir.sh"
#alias touch="ptTouch.sh"
#alias cp="ptCp.sh"
#alias rm="ptRm.sh"
#alias pwd="ptPwd.sh"

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# https://github.com/olivierverdier/zsh-git-prompt
# https://www.tweaking4all.com/software/macosx-software/customize-zsh-prompt/
# https://www.ditig.com/256-colors-cheat-sheet
precmd() { vcs_info }

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%{%F{green}B%} %{%b%f%}'
zstyle ':vcs_info:*' unstagedstr '%{%F{red}%B%} %{%b%f%}'
zstyle ':vcs_info:git:*' formats '%{%F{214}%} %{%F{137}%}(%{%F{214}%b%B%}%c%u%{%F{137}%})'

setopt PROMPT_SUBST
PROMPT='%{%F{240}%}%c ${vcs_info_msg_0_}%f: '
