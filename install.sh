#!/bin/bash

# exit on fail
set -e

#chromebrew directories
OWNER="${OWNER:-skycocker}"
REPO="${REPO:-chromebrew}"
BRANCH="${BRANCH:-master}"
URL="https://raw.githubusercontent.com/${OWNER}/${REPO}/${BRANCH}"
CREW_PREFIX="${CREW_PREFIX:-/usr/local}"
CREW_LIB_PATH="${CREW_PREFIX}/lib/crew/"
CREW_CONFIG_PATH="${CREW_PREFIX}/etc/crew/"
CREW_BREW_DIR="${CREW_PREFIX}/tmp/crew/"
CREW_DEST_DIR="${CREW_BREW_DIR}/dest"
CREW_PACKAGES_PATH="${CREW_LIB_PATH}/packages"
CURL="${CURL:-curl}"

ARCH="$(uname -m)"

GREEN='\e[1;32m';
RED='\e[1;31m';
BLUE='\e[1;34m';
YELLOW='\e[1;33m';
RESET='\e[0m'

if [ "${EUID}" == "0" ]; then
  echo -e "${RED}Chromebrew should not be installed or run as root.${RESET}"
  exit 1;
fi

case "${ARCH}" in
"i686"|"x86_64"|"armv7l"|"aarch64")
  LIB_SUFFIX=
  [ "${ARCH}" == "x86_64" ] && LIB_SUFFIX='64'
  ;;
*)
  echo -e "${RED}Your device is not supported by Chromebrew yet :/${RESET}"
  exit 1;;
esac

# install a base set of development packages for compiling and building software
echo -e -n "${BLUE}Install development tools? (not needed for most users) [y/N]: ${RESET}"; read -n1 devtools

# This will allow things to work without sudo
crew_folders="bin cache doc docbook etc include lib lib$LIB_SUFFIX libexec man sbin share tmp var"
for folder in $crew_folders
do
  if [ -d "${CREW_PREFIX}"/"${folder}" ]; then
    sudo chown -R "$(id -u)":"$(id -g)" "${CREW_PREFIX}"/"${folder}"
  fi
done
sudo chown "$(id -u)":"$(id -g)" "${CREW_PREFIX}"
# Delete 'var' symlink on Cloudready platform
if [[ $(grep neverware /etc/lsb-release) != "" ]]; then
  [ -L /usr/local/var ] && sudo rm -f /usr/local/var
  [ -L /usr/local/local ] && sudo rm -f /usr/local/local
fi

# prepare directories
for dir in "${CREW_CONFIG_PATH}/meta" "${CREW_DEST_DIR}" "${CREW_PACKAGES_PATH}"; do
  if [ ! -d "${dir}" ]; then
    mkdir -p "${dir}"
  fi
done

# create the device.json file if it doesn't exist
cd "${CREW_CONFIG_PATH}"
if [ ! -f device.json ]; then
  echo -e "${YELLOW}Creating new device.json...${RESET}"
  echo '{' > device.json
  echo '  "architecture": "'"${ARCH}"'",' >> device.json
  echo '  "installed_packages": [' >> device.json
  echo '  ]' >> device.json
  echo '}' >> device.json
fi

# functions to maintain packages
function download_check () {
    cd "${CREW_BREW_DIR}"

    #download
    echo -e "${BLUE}Downloading ${1}...${RESET}"
    # Gitlab doesn't support byte ranges, hence no need for "-C"
    # --ssl is only valid for (FTP IMAP POP3 SMTP)
    $CURL '-#' -L "${2}" -o "${3}"

    #verify
    echo -e "${BLUE}Verifying ${1}...${RESET}"
    echo -e "${GREEN}$(echo "${4}" "${3}" | sha256sum -c -)${RESET}"
    case "${?}" in
    0) ;;
    *)
      echo -e "${RED}Verification failed, something may be wrong with the download.${RESET}"
      exit 1;;
    esac
}

function extract_install () {
    # Start with a clean slate
    rm -rf "${CREW_DEST_DIR}"
    mkdir "${CREW_DEST_DIR}"
    cd "${CREW_DEST_DIR}"

    #extract and install
    echo "Extracting ${1} (this may take a while)..."
    if ! LD_LIBRARY_PATH=${CREW_PREFIX}/lib${LIB_SUFFIX}:/lib${LIB_SUFFIX} pixz -h &> /dev/null; then
      tar xpf ../"${2}"
    else
      LD_LIBRARY_PATH=${CREW_PREFIX}/lib${LIB_SUFFIX}:/lib${LIB_SUFFIX} tar -Ipixz -xpf ../"${2}"
    fi
    echo "Installing ${1} (this may take a while)..."
    tar cpf - ./*/* | (cd /; tar xp --keep-directory-symlink -f -)
    mv ./dlist "${CREW_CONFIG_PATH}/meta/${1}.directorylist"
    mv ./filelist "${CREW_CONFIG_PATH}/meta/${1}.filelist"
}

function update_device_json () {
  cd "${CREW_CONFIG_PATH}"

  if grep '"name": "'"${1}"'"' device.json > /dev/null; then
    echo "Updating version number of ${1} in device.json..."
    sed -i device.json -e '/"name": "'"${1}"'"/N;//s/"version": ".*"/"version": "'"${2}"'"/'
  elif grep '^    }$' device.json > /dev/null; then
    echo "Adding new information on ${1} to device.json..."
    sed -i device.json -e '/^    }$/s/$/,\
    {\
      "name": "'"${1}"'",\
      "version": "'"${2}"'"\
    }/'
  else
    echo "Adding new information on ${1} to device.json..."
    sed -i device.json -e '/^  "installed_packages": \[$/s/$/\
    {\
      "name": "'"${1}"'",\
      "version": "'"${2}"'"\
    }/'
  fi
}

function download_extract_update () {
  for package in ${1}; do
    pkgfile="$($CURL -Lsf "${URL}"/packages/"$package".rb)"
    url="$(echo "$pkgfile" | grep -m 3 "$ARCH": | head -n 1 | cut -d\' -f2 | tr -d \' | tr -d \" | sed 's/,//g')"
    sha256="$(echo "$pkgfile" | grep -m 3 "$ARCH": | tail -n 1 | cut -d\' -f2 | tr -d \' | tr -d \" | sed 's/,//g')"
    tarfile="$(basename ${url})"
    name="${tarfile%%-*}"   # extract string before first '-'
    rest="${tarfile#*-}"    # extract string after first '-'
    version="$(echo ${rest} | sed -e 's/-chromeos.*$//')" # extract string between first '-' and "-chromeos"
    download_check "${name}" "${url}" "${tarfile}" "${sha256}"
    extract_install "${name}" "${tarfile}"
    update_device_json "${name}" "${version}"
  done
}

case "${ARCH}" in
"armv7l"|"aarch64")
  if ! type "xz" > /dev/null; then
    url='https://github.com/snailium/chrome-cross/releases/download/v1.8.1/xz-5.2.3-chromeos-armv7l.tar.gz'
    sha256='4dc9f086ee7613ab0145ec0ed5ac804c80c620c92f515cb62bae8d3c508cbfe7'
    tarfile="$(basename ${url})"
    name="${tarfile%%-*}"   # extract string before first '-'
    rest="${tarfile#*-}"    # extract string after first '-'
    version="$(echo ${rest} | sed -e 's/-chromeos.*$//')" # extract string between first '-' and "-chromeos"
    download_check "${name}" "${url}" "${tarfile}" "${sha256}"
    extract_install "${name}" "${tarfile}"
    update_device_json "${name}" "${version}"
  fi
  ;;
esac

# install packages to get pixz working
# NOTE: pixz dependency package binaries cannot use pixz
COMPRESSION_PACKAGES="libarchive openssl zstd xzutils lz4 bz2 libxml2 pixz"
download_extract_update "${COMPRESSION_PACKAGES}"

# install remaining core packages
# NOTE: sha256 needs updated if core_packages.txt is changed
name=core_packages.txt
tmpfile=/tmp/${name}
url=https://raw.githubusercontent.com/${OWNER}/${REPO}/master/tools/${name}
sha256=d0fa5af6098ab037aa1952af3790874a2a25f5899419fabbc3530b895a46ba20
download_check "${name}" "${url}" "${tmpfile}" "${sha256}"
CORE_PACKAGES=$(cat "${tmpfile}" | xargs)
rm -f "${tmpfile}"
PACKAGES=
for package in ${CORE_PACKAGES}; do
  [ -z "$(echo ${COMPRESSION_PACKAGES} | tr ' ' '\n' | grep -e ^${package}$)" ] && PACKAGES+=" $package"
done
download_extract_update "${PACKAGES}"

## workaround https://github.com/skycocker/chromebrew/issues/3305
sudo ldconfig &> /dev/null || true

# create symlink to 'crew' in ${CREW_PREFIX}/bin/
ln -sfv "../lib/crew/bin/crew" "${CREW_PREFIX}/bin/"

# prepare sparse checkout .rb packages directory and do it
cd "${CREW_LIB_PATH}"
rm -rf .git
git init
git remote add -f origin "https://github.com/${OWNER}/${REPO}.git"
git config core.sparsecheckout true
echo packages >> .git/info/sparse-checkout
echo lib >> .git/info/sparse-checkout
echo bin >> .git/info/sparse-checkout
echo crew >> .git/info/sparse-checkout
echo tools   >> .git/info/sparse-checkout
git fetch origin "${BRANCH}"
git reset --hard origin/"${BRANCH}"
crew update

[[ "$devtools" == "y" || "$devtools" == "Y" ]] && yes | crew install buildessential

echo
if [[ "${CREW_PREFIX}" != "/usr/local" ]]; then
  echo -e "${YELLOW}
Since you have installed Chromebrew in a directory other than '/usr/local',
you need to run these commands to complete your installation:
${RESET}"

  echo -e "${BLUE}
echo 'export CREW_PREFIX=${CREW_PREFIX}' >> ~/.bashrc
echo 'export PATH=\"\${CREW_PREFIX}/bin:\${CREW_PREFIX}/sbin:\${PATH}\"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=${CREW_PREFIX}/lib${LIB_SUFFIX}' >> ~/.bashrc
source ~/.bashrc
${RESET}"
fi
echo -e "${BLUE}
Edit ${CREW_PREFIX}/etc/env.d/02-pager to change the default PAGER.
more is used by default

You may wish to edit the ${CREW_PREFIX}/etc/env.d/01-editor file for an editor default.

Chromebrew provides nano, vim and emacs as default TUI editor options.

${RESET}"
echo -e "${GREEN}Chromebrew installed successfully and package lists updated.${RESET}"
