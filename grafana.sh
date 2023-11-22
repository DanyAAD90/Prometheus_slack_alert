#!/bin/bash

# set -x
# wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian11_all.deb
# dpkg -i zabbix-release_6.4-1+debian11_all.deb
# apt-get update

# apt-get install -y zabbix-agent2 zabbix-agent2-plugin-*
# apt-get clean

# sed -i "s/^Server.*=.*127.0.0.1/Server=192.168.56.20/" /etc/zabbix/zabbix_agent2.conf
# sed -i "s/^ServerActive.*=.*127.0.0.1/ServerActive=192.168.59.20:10051/" /etc/zabbix/zabbix_agent2.conf

# systemctl restart zabbix-agent2
# systemctl enable zabbix-agent2

sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt-get update -y

sudo apt-get install grafana -y

sudo apt-get install grafana-enterprise -y

sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server
sudo systemctl status grafana-server

sudo systemctl enable grafana-server.service
sudo systemctl restart grafana-server




