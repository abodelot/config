PROMPT='%{$fg_bold[cyan]%}%~ $(git_prompt_info)'
PROMPT+="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}"

local return_code="%(?..%{$fg_bold[red]%}:( %?%{$reset_color%})"
local time="%{$fg_bold[yellow]%}[%*]%{$reset_color%}"
RPS1='${return_code} ${time}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}×%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
