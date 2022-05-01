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
export PATH="$PYENV_ROOT/bin:$HOME/.rbenv/bin:$HOME/.local/bin:/home/ethan/.cargo/bin:$PATH"
export EDITOR=nvim

[ -f /usr/bin/nvim ] && alias vi=nvim
#[ -f /home/ethan/.local/bin/lvim ] && alias vi=lvim
[ -f /usr/bin/exa ] && alias ls="exa -bl --git --icons --time-style long-iso --group-directories-first"
[ -f /usr/bin/bat ] && alias cat=bat
alias f=ranger
alias pacman_clean='sudo pacman -Rns $(pacman -Qtdq)'

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

# old prompt
# # Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:*' check-for-changes true
# #zstyle ':vcs_info:*' unstagedstr ' '
# #zstyle ':vcs_info:*' stagedstr ' '
# zstyle ':vcs_info:*' stagedstr '%{%F{green}B%} %{%b%f%}'
# zstyle ':vcs_info:*' unstagedstr '%{%F{red}%B%} %{%b%f%}'
# zstyle ':vcs_info:git:*' formats '%{%F{214}%} %{%F{214}%}(%{%F{137}%b%B%}%c%u%{%F{214}%})'
#
# # Set up the prompt (with git branch name)
setopt PROMPT_SUBST
# #PROMPT='(%m)${NEWLINE}%c ${vcs_info_msg_0_} > '
# #PROMPT='%{%F{137}%}%c ${vcs_info_msg_0_}%f> '
NT_PROMPT_SYMBOL=❱
# # PROMPT='[%{$fg_bold[white]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)%{$reset_color%}]$ '
#
# ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg_bold[green]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX=")"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}✗%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"
#
# end old prompt

# new maybe kolo
# zstyle ':vcs_info:*' stagedstr '%F{green}●'
# zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:svn:*' branchformat '%b'
# zstyle ':vcs_info:svn:*' formats ' [%b%F{1}:%F{11}%i%c%u%B%F{green}]'
# zstyle ':vcs_info:*' enable git svn
#
# theme_precmd () {
#   if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
#     zstyle ':vcs_info:git:*' formats ' [%b%c%u%B%F{green}]'
#   else
#     zstyle ':vcs_info:git:*' formats ' [%b%c%u%B%F{red}●%F{green}]'
#   fi
#
#   vcs_info
# }
#
# setopt prompt_subst
# PROMPT='%B%F{magenta}%c%B%F{green}${vcs_info_msg_0_}%B%F{magenta} %{$reset_color%}%% '
#
# autoload -U add-zsh-hook
# add-zsh-hook precmd  theme_precmd
# end maybe kolo
#
# prompt style and colors based on Steve Losh's Prose theme:
# https://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
# vcs_info modifications from Bart Trojanowski's zsh prompt:
# http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#
# git untracked files modification from Brian Carper:
# https://briancarper.net/blog/570/git-info-in-your-zsh-prompt

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('%F{blue}`basename $VIRTUAL_ENV`%f') '
}
PR_GIT_UPDATE=1

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

#use extended color palette if available
if [[ $terminfo[colors] -ge 256 ]]; then
    turquoise="%F{81}"
    orange="%F{166}"
    purple="%F{135}"
    hotpink="%F{161}"
    limegreen="%F{118}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%f"
FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
FMT_UNSTAGED="%{$orange%}●"
FMT_STAGED="%{$limegreen%}●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function steeef_preexec {
    case "$2" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *hub*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec steeef_preexec

function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd

function steeef_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="(%{$turquoise%}%b%u%c%{$hotpink%}●${PR_RST})"
        else
            FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd

PROMPT=$'
%{$purple%}%n${PR_RST}@%{$orange%}%m${PR_RST} in %{$limegreen%}%~${PR_RST} $vcs_info_msg_0_$(virtualenv_info)
${NT_PROMPT_SYMBOL} '

