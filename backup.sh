#!/bin/bash
#BASH SCRIPT CRIADO PARA REALIZAR BACKUP DOS DADOS PESSOAIS COM RSYNC
#CRIADOR: Israel Comazzetto dos Reis

set -o errexit
set -o nounset
set -o pipefail

readonly SOURCE_DIR="${HOME}"
readonly BACKUP_DIR="/backup_israel"
readonly DATETIME="$(date '+%Y-%m-%d')"
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly LATEST_LINK="${BACKUP_DIR}/latest"

rsync -z -av --delete \
  "${SOURCE_DIR}/" \
  --link-dest "${LATEST_LINK}" \
  --exclude=".cache" \
  "${BACKUP_PATH}"
  
rm -rf "${LATEST_LINK}"
cd /backup_israel/ && tar -czf $DATETIME.tar.gz $DATETIME
rm -rf /backup_israel/$DATETIME/
ln -s "/backup_israel/$DATETIME.tar.gz" "${LATEST_LINK}"
