#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
pginstall () {
# Runs through the install process order
  updateprime
  bash /pg/stage/functions/gcechecker.sh
  # - good - core pythonstart
  # - good - core aptupdate
  core alias_install &>/dev/null &
  core folders
  serverid
  # - good - core dependency
  # - good - core mergerinstall
  # - ok (need to skip those ignore containers - core dockerinstall
  core docstart

touch /pg/var/install.roles
rolenumber=3
  # Roles Ensure that PG Replicates and has once if missing; important for startup, cron and etc
if [[ $(cat /pg/var/install.roles) != "$rolenumber" ]]; then
  rm -rf /pg/communityapps
  rm -rf /pg/coreapps
  rm -rf /pg/pgshield

  pgcore
  pgcommunity
  pgshield
  echo "$rolenumber" > /pg/var/install.roles
fi

  portainer
  # !!! fix !!! - pgui
  core motd &>/dev/null &
  core hetzner &>/dev/null &
  # [good] core gcloud
  core watchtower
  core prune
  customcontainers &>/dev/null &
  pgedition
  core mountcheck
  emergency
  pgdeploy
}
