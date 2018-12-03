#!/usr/bin/env bash
SCM_THEME_PROMPT_DIRTY="${orange}*"
SCM_THEME_PROMPT_CLEAN=""
SCM_THEME_PROMPT_PREFIX=" |"
SCM_THEME_PROMPT_SUFFIX="${green}|"

GIT_THEME_PROMPT_DIRTY="${orange}*"
GIT_THEME_PROMPT_CLEAN=""
GIT_THEME_PROMPT_PREFIX="${yellow}("
GIT_THEME_PROMPT_SUFFIX="${yellow})"

function prompt_command() {
    PS1="\n${cyan}\u ${yellow}📂 ${cyan}\w\n${yellow}$(scm_prompt_info) ${yellow}→${reset_color} "
}

PROMPT_COMMAND=prompt_command;
