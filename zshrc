export CLICOLOR=1
export ELLIPSIS_PATH=~/.ellipsis
export GOPATH="$HOME/go"
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=${HISTSIZE}
export ISSUES_DIR=~/src/tasks
export JENKINS_LOGS_DIR=~/doc/builds.apache.org/job
JENKINS_JOBS=(Ambari-branch-2.6 Ambari-branch-2.7 Ambari-trunk-Commit Ambari-Github-PullRequest-Builder)
export REPO_HOST=repo
export TERM="xterm-256color"
export UAZ_PATH=~/src/uaz

setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Ambari
export APACHE_AMBARI_UTILS_PATH=~/src/apache-ambari-utils
export HWX_AMBARI_UTILS_PATH=~/src/hwx-ambari-utils
export AMBARI_VAGRANT_PATH=~/src/ambari-vagrant
export AMBARI_PROJECT=~/src/ambari

export JENKINS_URL="https://builds.apache.org"
export JIRA_URL="https://issues.apache.org/jira"

export PATH=~/bin:$PATH:${ELLIPSIS_PATH}/bin

[[ -d ${GOPATH} ]] && export PATH="${PATH}:${GOPATH}/bin"

[[ -f /usr/local/bin/lesspipe.sh ]] && export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1

alias abgen='type make >/dev/null && make -f ~/.zsh_plugins.make ~/.zsh_plugins.zsh' # antibody bundle
alias bc='bc -lq'
alias e='ellipsis'
alias grevne='git revert --no-edit'
alias grevnc='git revert --no-commit'
alias gsff='git show --format=fuller --show-signature'
alias mvim='mvim -p'
alias pygrep="grep --include '*.py'"
alias R='R --quiet'

umask 077

fpath+=(${ELLIPSIS_PATH}/comp)

autoload -U compinit
compinit

source_safe() {
	[[ -f "$1" ]] && source "$1"
}

source_safe ~/.travis/travis.sh # travis gem

source_safe ~/.functions
source_safe ~/.ambari_functions

if source_safe ${UAZ_PATH}/source_all; then
  source-all ${UAZ_PATH}
  source-all ${APACHE_AMBARI_UTILS_PATH}
  source-all ${HWX_AMBARI_UTILS_PATH}
fi

source_safe ~/.platform.zsh
source_safe ~/.host.zsh
source_safe ~/.private.zsh
abgen --silent ~/.zsh_plugins.zsh
source_safe ~/.zsh_plugins.zsh
source_safe ~/.todo.cfg

bindkey ' ' magic-space

if type direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi
