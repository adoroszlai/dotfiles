export GOPATH="$HOME/go"
export ISSUES_DIR=~/src/tasks
export JENKINS_LOGS_DIR=~/doc/builds.apache.org/job
export JENKINS_JOBS=(Ambari-branch-2.6 Ambari-branch-2.7 Ambari-trunk-Commit Ambari-Github-PullRequest-Builder)
export REPO_HOST=repo
export TERM="xterm-256color"
export UAZ_PATH=~/src/uaz

# Ambari
export APACHE_AMBARI_UTILS_PATH=~/src/apache-ambari-utils
export HWX_AMBARI_UTILS_PATH=~/src/hwx-ambari-utils
export AMBARI_VAGRANT_PATH=~/src/ambari-vagrant
export AMBARI_PROJECT=~/src/ambari

export JENKINS_URL="https://builds.apache.org"
export JIRA_URL="https://issues.apache.org/jira"

export PATH=~/bin:$PATH:~/.ellipsis/bin

[[ -d ${GOPATH} ]] && export PATH="${PATH}:${GOPATH}/bin"

[[ -f /usr/local/bin/lesspipe.sh ]] && export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1

alias abgen='type make >/dev/null && make -f ~/.zsh_plugins.make' # antibody bundle
alias bc='bc -lq'
alias grevne='git revert --no-edit'
alias grevnc='git revert --no-commit'
alias gsff='git show --format=fuller --show-signature'
alias mvim='mvim -p'
alias pygrep="grep --include '*.py'"
alias R='R --quiet'
alias t='todo.sh'

umask 077

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

bindkey ' ' magic-space

type direnv >/dev/null && eval "$(direnv hook zsh)"
