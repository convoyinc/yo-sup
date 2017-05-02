if [[ "${ROOT_DIR}" == "" ]]; then
  echo "Bug: ROOT_DIR must be specified before including npm.sh"
  exit 1
fi

export NODE_MODULE_ROOT="${ROOT_DIR}"/modules
export NODE_BIN_PATH="${NODE_MODULE_ROOT}"/node_modules/.bin

if hash yarn 2> /dev/null; then export HAS_YARN=1; else export HAS_YARN=0; fi

add_or_update_package() {
  PACKAGE_SPEC="${1}"
  if [[ ! "${PACKAGE_SPEC}" =~ @.*$ ]]; then
    PACKAGE_SPEC="${PACKAGE_SPEC}"@latest
  fi

  if (( HAS_YARN )); then
    run_in_modules yarn add "${PACKAGE_SPEC}"
  else
    run_in_modules npm install "${PACKAGE_SPEC}"
  fi
}

remove_package() {
  PACKAGE_NAME="${1}"

  if (( HAS_YARN )); then
    run_in_modules yarn remove "${PACKAGE_NAME}"
  else
    run_in_modules npm uninstall "${PACKAGE_NAME}"
  fi
}

# It would be neat if we could just specify --modules-folder or --prefix, but
# yarn doens't like removing modules that aren't directly in node_modules.
run_in_modules() {
  mkdir -p "${NODE_MODULE_ROOT}"
  pushd "${NODE_MODULE_ROOT}" > /dev/null

  "${@}"

  popd > /dev/null
}
