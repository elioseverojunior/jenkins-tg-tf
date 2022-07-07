#!/usr/bin/env bash

# set -x

CWD=$(pwd)
REGION="${1:-us-east-1}"
DEPLOYMENT_TYPE="${2:-deploy}"
DEPLOYMENT_APP="$(pwd)/deployment/tools"
DEPLOYEMNT_DIR="${DEPLOYMENT_APP}/${REGION}/nickel/jenkins"

function main() {
  if [ -d "${DEPLOYEMNT_DIR}" ];
  then
    echo "${DEPLOYEMNT_DIR}"
    if [ "${DEPLOYMENT_TYPE}" == "deploy" ];
    then
      APPS=( $(find ${DEPLOYEMNT_DIR} -type d -maxdepth 1 -mindepth 1 -exec basename {} \; | sort) )
      for APP in "${APPS[@]}";
      do
        APP_DIR="${DEPLOYEMNT_DIR}/${APP}"
        echo "${APP_DIR}"
        cd "${APP_DIR}"
        terragrunt init\
         && terragrunt plan -input=false\
         && terragrunt apply -input=false -auto-approve
        cd "${CWD}"
      done
    elif [ "${DEPLOYMENT_TYPE}" == "destroy" ];
    then
      APPS=( $(find ${DEPLOYEMNT_DIR} -type d -maxdepth 1 -mindepth 1 -exec basename {} \; | sort -r) )
      for APP in "${APPS[@]}";
      do
        APP_DIR="${DEPLOYEMNT_DIR}/${APP}"
        echo "${APP_DIR}"
        cd "${APP_DIR}"
        terragrunt init\
         && terragrunt plan -input=false\
         && terragrunt destroy -auto-approve\
        cd "${CWD}"
      done
    else
      echo -e "Nothing to do."
    fi
  else
    echo -e "There's no code available to deploy into \"${REGION}\". Please try to choose someone of regions below:";
    find "${DEPLOYMENT_APP}" -type d -maxdepth 1 -mindepth 1 -exec basename {} \;
    echo -e
  fi
  cd "${CWD}"
}

time main
