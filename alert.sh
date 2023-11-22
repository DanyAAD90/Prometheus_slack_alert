#!/bin/bash

cd ~/Downloads

wget https://github.com/prometheus/alertmanager/releases/download/v0.22.2/alertmanager-0.22.2.linux-amd64.tar.gz

tar xzf alertmanager-0.22.2.linux-amd64.tar.gz

sudo mv -v alertmanager-0.22.2.linux-amd64 /opt/alertmanager

sudo chown -Rfv root:root /opt/alertmanager

sudo mkdir -v /opt/alertmanager/data

sudo chown -Rfv prometheus:prometheus /opt/alertmanager/data

#sudo nano /etc/systemd/system/alertmanager.service
# -------------------------
lines=("
[Unit]"
"Description=Alertmanager for prometheus"
""
"[Service]"
"Restart=always"
"User=prometheus"
"ExecStart=/opt/alertmanager/alertmanager --config.file=/opt/alertmanager/alertmanager.yml --storage.path=/opt/alertmanager/data"
"ExecReload=/bin/kill -HUP \$MAINPID"
"TimeoutStopSec=20s"
"SendSIGKILL=no"
""
"[Install]"
"WantedBy=multi-user.target"
)

for line in "${lines[@]}"; do
  echo "$line" >> /etc/systemd/system/alertmanager.service
done
# -------------------------
sudo systemctl daemon-reload
sudo systemctl start alertmanager.service
sudo systemctl enable alertmanager.service
sudo systemctl status alertmanager.service

hostname -I
# -------------------------
lines=(
"- job_name: 'alertmanager'"
"  static_configs:"
" - targets: ['192.168.56.30:9093'])"
)

for line in "${lines[@]}"; do
  echo "$line" >> /opt/prometheus/prometheus.yml
done
# -------------------------
sudo systemctl restart prometheus.service