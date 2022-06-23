#!/usr/bin/env sh

set +x -eo pipefail

TFENV_CURL_OUTPUT=0
export TFENV_CURL_OUTPUT=${TFENV_CURL_OUTPUT}

function get_terraform_version() {
  echo "$(terraform version 2> /dev/null | head -1 | awk -F"v" '{print $2}')"
}

function get_tfenv_latest_version() {
  echo "$(tfenv list-remote | grep -E '^\d.\d.\d$' | head -n 1)"
}

TFENV="${HOME}/.tfenv"
LOCAL_BIN="${HOME}/.local/bin/"
TFENV_VERSION="${1:-$(get_tfenv_latest_version)}"
TERRAFORM_VERSION=$(get_terraform_version)

if [ "${TFENV_VERSION}" == "latest" ];
then
  TFENV_VERSION=$(get_tfenv_latest_version)
fi

if [ ! -d "${TFENV}" ];
then
  git clone https://github.com/tfutils/tfenv.git "${TFENV}"
  mkdir -p "${LOCAL_BIN}"
  ln -s ${TFENV}/bin/* ${LOCAL_BIN}
  sh -c "which tfenv"
  echo 'trust-tfenv: yes' > ${TFENV}/use-gpgv
fi

if [ "$(tfenv list | grep "${TFENV_VERSION}")" = "" ];
then
  tfenv install "${TFENV_VERSION}"
fi

if [ "${TERRAFORM_VERSION}" != "${TFENV_VERSION}" ];
then
  tfenv use "${TFENV_VERSION}"
fi

echo
echo "Current Terraform Version is: $(get_terraform_version)"
echo
