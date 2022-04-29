#!/bin/bash
# shortcuts.sh - A script to shorten the linux command for your convinient.
# Author: Max Vuong
# Date: 04/28/2021

: <<'COMMENT_BLOCK'
Run this command to add aliases to your .bashrc
> curl -L https://raw.githubusercontent.com/xuyenvuong/pi4-pos-setup/master/scripts/alias.sh | bash | source $HOME/.bashrc

Description:
Supporting services [beacon, validator, eth2-stats, geth, prometheus, prometheus-node-exporter, grafana]
Supporting post-fixes [-log, -start, -stop, -restart, -enable]

Usage: Add post-fixes after your service name e.g. [service]-log.
Example: "beacon-log", "validator-restart", "geth-stop', ect...

Test, view beacon log by typing at the command prompt:
> beacon-log

COMMENT_BLOCK

# ---------------------------------------------------------------
# Check and install ccze (log with colors)
dpkg_name=ccze

if [ $(dpkg-query -W -f='${Status}' $dpkg_name 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  logger "Installing: $dpkg_name"
  sudo apt install -y $dpkg_name
fi

# ---------------------------------------------------------------

echo "Adding aliases to .bashrc file"

sudo cat << EOF | sudo tee -a $HOME/.bashrc >/dev/null

# Aliases for Node

alias beacon-log='journalctl -f -u prysm-beacon.service -n 200 | ccze -A'
alias validator-log='journalctl -f -u prysm-validator.service -n 200 | ccze -A'
alias eth2-stats-log='journalctl -f -u eth2-client-metrics-exporter.service -n 200 | ccze -A'
alias geth-log='journalctl -f -u geth.service -n 200 | ccze -A'
alias prometheus-log='journalctl -f -u prometheus -n 200 | ccze -A'
alias prometheus-node-exporter-log='journalctl -f -u prometheus-node-exporter -n 200 | ccze -A'
alias grafana-log='journalctl -f -u grafana-server -n 200 | ccze -A'

alias beacon-start='sudo systemctl start prysm-beacon.service'
alias validator-start='sudo systemctl start prysm-validator.service'
alias eth2-stats-start='sudo systemctl start eth2-client-metrics-exporter.service'
alias geth-start='sudo systemctl start geth.service'
alias prometheus-start='sudo systemctl start prometheus'
alias prometheus-node-exporter-start='sudo systemctl start prometheus-node-exporter'
alias grafana-start='sudo systemctl start grafana-server'

alias beacon-stop='sudo systemctl stop prysm-beacon.service'
alias validator-stop='sudo systemctl stop prysm-validator.service'
alias node-exporter-stop='sudo systemctl stop eth2-client-metrics-exporter.service'
alias geth-stop='sudo systemctl stop geth.service'
alias prometheus-stop='sudo systemctl stop prometheus'
alias prometheus-node-exporter-stop='sudo systemctl stop prometheus-node-exporter'
alias grafana-stop='sudo systemctl stop grafana-server'

alias beacon-restart='sudo systemctl restart prysm-beacon.service'
alias validator-restart='sudo systemctl restart prysm-validator.service'
alias eth2-stats-restart='sudo systemctl restart eth2-client-metrics-exporter.service'
alias geth-restart='sudo systemctl restart geth.service'
alias prometheus-restart='sudo systemctl restart prometheus'
alias prometheus-node-exporter-restart='sudo systemctl restart prometheus-node-exporter'
alias grafana-restart='sudo systemctl restart grafana-server'

alias beacon-enable='sudo systemctl enable prysm-beacon.service'
alias validator-enable='sudo systemctl enable prysm-validator.service'
alias eth2-stats-enable='sudo systemctl enable eth2-client-metrics-exporter.service'
alias geth-enable='sudo systemctl enable geth.service'
alias prometheus-enable='sudo systemctl enable prometheus'
alias prometheus-node-exporter-enable='sudo systemctl enable prometheus-node-exporter'
alias grafana-enable='sudo systemctl enable grafana-server'

EOF