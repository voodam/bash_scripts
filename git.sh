git_set_remote_user() {
  local project=$(git remote -v | head -1 | grep -oE '[a-z-]+\.git' | sed s/.git//)
  git remote set-url origin git@github.com:${1}/${project}.git
  git remote -v
}

git_rebase_master() {
  local branch=$(git_cur_branch)
  local master="${1:-master}"
  git checkout "$master"
  git pull
  git rebase "$master" "$branch"
  git checkout "$branch"
}

git_find_gca() {
  git show `git rev-list ${1:-5.7} ^${2:-origin/8.0} --first-parent --topo-order | tail -1`^ | head -1 | awk '{print $2}'
}
git_gca() {
  git checkout -b $1 $(git_find_gca $2 $3);
}

alias gst="git status"
alias gch="git checkout"
alias git_cur_branch="git rev-parse --abbrev-ref HEAD"
alias git_sub="git submodule update --init --recursive"
alias git_del_last_commit="git reset --hard HEAD~1"
alias git_amend="git commit --amend --no-edit"
git_amend_push()        { git_amend; git push -f; }
git_del_local_branch() 	{ git branch -D "$1"; }
git_del_remote_branch() { git push origin --delete "${1:-$(git_cur_branch)}"; }
