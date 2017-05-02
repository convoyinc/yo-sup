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

link_package() {
  PACKAGE_NAME="${1}"

  if (( HAS_YARN )); then
    run_in_modules yarn link "${PACKAGE_NAME}"
  else
    run_in_modules npm link "${PACKAGE_NAME}"
  fi
}

package_is_generator() {
  npm view "${1}" keywords 2> /dev/null | grep "'yeoman-generator'" > /dev/null
}

package_exists() {
  npm view "${1}" name > /dev/null 2>&1
}

resolve_generator() {
  GENERATOR="${1}"

  if ! package_is_generator "${GENERATOR}"; then
    if [[ "${GENERATOR}" =~ ^(@.+)/(.+)$ ]]; then
      MAYBE_GENERATOR="${BASH_REMATCH[1]}"/generator-"${BASH_REMATCH[2]}"
    else
      MAYBE_GENERATOR=generator-"${GENERATOR}"
    fi

    if package_is_generator "${MAYBE_GENERATOR}"; then
      GENERATOR="${MAYBE_GENERATOR}"
    fi
  fi

  echo "${GENERATOR}"
}

# It would be neat if we could just specify --modules-folder or --prefix, but
# yarn doens't like removing modules that aren't directly in node_modules.
run_in_modules() {
  mkdir -p "${NODE_MODULE_ROOT}"
  pushd "${NODE_MODULE_ROOT}" > /dev/null

  "${@}"

  popd > /dev/null
}
