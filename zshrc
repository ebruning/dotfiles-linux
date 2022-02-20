HISTSIZE=1000               #How many lines of history to keep in memory
SAVEHIST=1000               #Number of history entries to save to disk
HISTFILE=~/.zsh_history     #Where to save history to disk
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

source ~/Projects/dotfiles-linux/scripts/git.zsh
autoload -U colors && colors
autoload -Uz compinit && compinit
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

eval "$(pyenv init --path)"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# https://github.com/olivierverdier/zsh-git-prompt
# https://www.tweaking4all.com/software/macosx-software/customize-zsh-prompt/
#source ~/.local/bin/zshrc.sh
NEWLINE=$'\n'
#PROMPT='%F{178}%f[%n@%m]${NEWLINE}%c $(git_super_status) %# '
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:*' unstagedstr ' '
#zstyle ':vcs_info:*' stagedstr ' '
zstyle ':vcs_info:*' stagedstr '%{%F{green}B%} %{%b%f%}'
zstyle ':vcs_info:*' unstagedstr '%{%F{red}%B%} %{%b%f%}'
zstyle ':vcs_info:git:*' formats '%{%F{214}%} %{%F{214}%}(%{%F{137}%b%B%}%c%u%{%F{214}%})'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
#PROMPT='(%m)${NEWLINE}%c ${vcs_info_msg_0_} > '
#PROMPT='%{%F{137}%}%c ${vcs_info_msg_0_}%f> '

PROMPT='[%{$fg_bold[white]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)%{$reset_color%}]$ '

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"
