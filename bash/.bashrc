# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# added by Miniconda3 4.5.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/decval/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/decval/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/decval/miniconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/decval/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# User specific environment and startup programs
# SUPERCEDED - DAV 02/05
#parse_git_branch() {
#     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
#}
#export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# alias will not take arguments
#alias venv='source activate ~/venvs/{$1}

export VENVDIR=~/venvs

function venv(){
  source "$VENVDIR/$1/bin/activate"
}

# bash_prompt
# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"
 LIGHT_BLUE="\[\033[1;36m\]"

# Detect whether the current directory is a git repository.
function is_git_repository {
 git branch > /dev/null 2>&1
}

function set_git_branch {
 # Set the final branch string
 BRANCH="${LIGHT_GREEN}`parse_git_branch`${COLOR_NONE}"
 local TIME=`fmt_time` # format time for prompt string
}

function parse_git_branch() {
 git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Will still prompt with a * if untracked files present
function parse_git_dirty() {
 if [[ $(git status 2> /dev/null | tail -n1) != *"working tree clean"* ]]; then echo "*"; fi
}

fmt_time () { #format time just the way I likes it
   if [ `date +%p` = "PM" ]; then
       meridiem="pm"
   else
       meridiem="am"
   fi
   date +"%l:%M:%S$meridiem"|sed 's/ //g'
}


# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
 if test $1 -eq 0 ; then
     PROMPT_SYMBOL="\$"
 else
     PROMPT_SYMBOL="${LIGHT_RED}\$${COLOR_NONE}"
 fi
}

function check_conda_env ()
{
    if [ ! -z "$CONDA_DEFAULT_ENV" ]; then
       CONDA_ENV="${LIGHT_BLUE}[`basename \"$CONDA_DEFAULT_ENV\"`]${COLOR_NONE} "
    else
       CONDA_ENV=""
    fi
}

# Determine active Python virtualenv details.
function set_virtualenv () {
 if test -z "$VIRTUAL_ENV" ; then
     PYTHON_VIRTUALENV=""
 else
     PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
 fi
}

# Set the full bash prompt.
function set_bash_prompt () {
 # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
 # return value of the last command.
 set_prompt_symbol $?

 # Set the PYTHON_VIRTUALENV variable.
 set_virtualenv

 # Set the conda environment
 check_conda_env

 # Set the BRANCH variable.
 if is_git_repository ; then
   set_git_branch
 else
   BRANCH=''
 fi

 # Set the bash prompt variable.
 PS1="${CONDA_ENV}${PYTHON_VIRTUALENV}${YELLOW}\w${COLOR_NONE} ${BRANCH}${PROMPT_SYMBOL} "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt

