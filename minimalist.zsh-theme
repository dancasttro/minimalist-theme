# PROMPT="${FG[117]}%~%{$reset_color%} - \$(git_prompt_info) - \$(virtualenv_prompt_info)${FG[133]}\$(git_prompt_status)${FG[077]}$%{$reset_color%} "
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m %{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m %{$reset_color%}'
    local user_symbol='$'
fi

function get_pwd(){
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done
  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi
  echo $prompt_short_dir
}

PROMPT='$ret_status %{$fg[white]%}$(get_pwd) $(git_prompt_info)%{$reset_color%}%{$reset_color%}
%B${user_symbol}%b '
RPROMPT='%B${return_code}%b'

# Git info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✓%{$reset_color%}"

# Git status
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[magenta]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}>%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}=%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}?%{$reset_color%}"

