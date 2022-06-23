#!/usr/bin/env bash

set +x -eo pipefail

GIT_REPO_URI=$(git config --get remote.$(git remote).url)
IS_SSH_GIT_PROTOCOL=$(echo ${GIT_REPO_URI} | grep -qe "git@" && echo "true" || echo "false")

trim_dot_git() {
  echo "${1}" | sed 's|\.git||'
}

if [ "${IS_SSH_GIT_PROTOCOL}" = "true" ];
then
  echo "$(trim_dot_git $(echo https://$(echo ${GIT_REPO_URI} | awk -F'git@' '{print $2}' | sed 's|:|/|g')))"
else
  echo "$(trim_dot_git $(echo ${GIT_REPO_URI}))"
fi
