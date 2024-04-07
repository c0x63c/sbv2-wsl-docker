#!/bin/bash

set -Eeuo pipefail
declare -A MOUNTS

# mount folders
MOUNTS["/sbv2/model_assets"]="/volumes/model_assets"
MOUNTS["/sbv2/Data"]="/volumes/Data"
MOUNTS["/sbv2/inputs"]="/volumes/inputs"
MOUNTS["/sbv2/slm/wavlm-base-plus"]="/volumes/slm/wavlm-base-plus"
MOUNTS["/sbv2/bert"]="/volumes/bert"

# make symbolik link and copy target dir under the files.
for to_path in "${!MOUNTS[@]}"; do
  set -Eeuo pipefail
  from_path="${MOUNTS[${to_path}]}"
  if [ ! -f "$from_path" ]; then
    mkdir -vp "$from_path"
  fi
  if [ -d "$to_path" ]; then
    to_path_file="${to_path}/*"
    if [ -n "$(ls $to_path_file 2> /dev/null)" ]; then
      cp -f -p -r $to_path_file $from_path 2> /dev/null
    fi
  fi
  rm -r -f "${to_path}"
  mkdir -vp "$(dirname "${to_path}")"
  ln -sT "${from_path}" "${to_path}"
  echo Mounted $(basename "${from_path}")
done

if [ ! -e "/sbv2/Data/check" ]; then
  # change dont use caches hf_hub_download
  # TODO: If an argument that does not use cache is added in initialize.py then remove it
  sed -i 's@hf_hub_download("microsoft/wavlm-base-plus", file, local_dir=local_path)@hf_hub_download("microsoft/wavlm-base-plus", file, local_dir=local_path, local_dir_use_symlinks=False)@' initialize.py
  sed -i 's/hf_hub_download(v\["repo_id"\], file, local_dir=local_path)/hf_hub_download(v\["repo_id"\], file, local_dir=local_path, local_dir_use_symlinks=False)/g' initialize.py
  sed -i '/Style-Bert-VITS2-1.0-base/a , local_dir_use_symlinks=False' initialize.py
  sed -i '/Style-Bert-VITS2-2.0-base-JP-Extra/a , local_dir_use_symlinks=False' initialize.py
  # output check file
  echo "this file using only initialize check. if you want to run initialize.py remove this." > /sbv2/Data/check
  # exec initialize
  python initialize.py
fi

eval "$@"
