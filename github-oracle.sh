#!/bin/bash

declare -r main_url="https://raw.githubusercontent.com/DataDog/integrations-core/refs/heads/master/oracle/CHANGELOG.md"
declare -r log_file="/opt/changelog_update.log"

function getChangelog () {
  if [[ ! -f /opt/CHANGELOG.md ]]; then
    cd /opt && curl -s -O "${main_url}"
  else
    curl -s -o CHANGELOG.md.temp "${main_url}"
    md5_temp_value=$(md5sum CHANGELOG.md.temp | awk '{print $1}')
    md5_original_value=$(md5sum CHANGELOG.md | awk '{print $1}')
    if [[ "${md5_temp_value}" == "${md5_original_value}" ]]; then
      rm -f CHANGELOG.md.temp
    else
      timestamp=$(date '+%Y-%m-%d %H:%M:%S')
      echo "[${timestamp}] Se ha detectado una actualización en el CHANGELOG" >> "$log_file"
      mv CHANGELOG.md.temp CHANGELOG.md
    fi
  fi

}

# Loop principal
while true; do
  getChangelog
  sleep 120  # Espera 2 minutos
done

