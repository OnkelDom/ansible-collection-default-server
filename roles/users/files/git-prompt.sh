# ===================[ Erweiterter Bash Prompt mit Git-Status ]===================

# Farben für PS1 (Bash-escaped)
PS1_RESET="\[\e[0m\]"
PS1_RED="\[\e[0;31m\]"
PS1_GREEN="\[\e[0;32m\]"
PS1_YELLOW="\[\e[0;33m\]"
PS1_BLUE="\[\e[0;34m\]"
PS1_LIGHTBLUE="\[\e[1;34m\]"
PS1_CYAN="\[\e[0;36m\]"

# Git-Status ohne \[ \], aber mit ANSI
parse_git_branch() {
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch ahead behind
  local staged=0 unstaged=0 untracked=0 conflict=0

  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)

  while IFS= read -r line; do
    case "$line" in
      M*|A*|D*|R*|C*) ((staged++)) ;;
      *M) ((unstaged++)) ;;
      \?\?*) ((untracked++)) ;;
      UU*) ((conflict++)) ;;
    esac
  done < <(git status --porcelain 2>/dev/null)

  if git rev-parse --abbrev-ref --symbolic-full-name @{u} &>/dev/null; then
    ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
    behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)
  fi

  local result=" (\033[0;33m${branch}\033[0m"
  [[ "$ahead" -gt 0 ]]    && result+="\033[0;36m⇡${ahead}\033[0m"
  [[ "$behind" -gt 0 ]]   && result+="\033[0;36m⇣${behind}\033[0m"
  [[ "$staged" -gt 0 ]]   && result+="\033[0;32m+\033[0m"
  [[ "$unstaged" -gt 0 ]] && result+="\033[0;31m~\033[0m"
  [[ "$untracked" -gt 0 ]] && result+="\033[0;33m?\033[0m"
  [[ "$conflict" -gt 0 ]] && result+="\033[0;31m⧉\033[0m"
  result+=")"

  printf "%b" "$result"
}

# Prompt setzen mit parse_git_branch korrekt eingebunden
set_bash_prompt() {
  local user_color exit_str=""
  [[ $EUID -eq 0 ]] && user_color="${PS1_RED}" || user_color="${PS1_GREEN}"

  # Zeit und Datum
  local now="\$(date +'%F %T')"  # z. B. "2025-03-26 14:30:12"
  local now_str="${PS1_YELLOW}[${now}]${PS1_RESET}"

  # Exit-Code (nur wenn != 0)
  local last_exit=$?
  if [[ $last_exit -ne 0 ]]; then
    exit_str="${PS1_RED}✖${last_exit}${PS1_RESET} "
  fi

  PS1="${now_str} ${exit_str}${user_color}\u${PS1_RESET}@${PS1_LIGHTBLUE}\h${PS1_RESET}:${PS1_CYAN}\w${PS1_RESET}\$(parse_git_branch)\n\$ "
}

if [[ -z "${PROMPT_COMMAND:-}" ]]; then
  PROMPT_COMMAND=set_bash_prompt
fi
