#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus
sudo mkdir /var/lib/prometheus

for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done

sudo apt-get update
sudo apt-get -y install wget curl vim

mkdir -p /tmp/prometheus && cd /tmp/prometheus
curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -

tar xvf prometheus*.tar.gz
cd prometheus*/

sudo mv prometheus promtool /usr/local/bin/

sudo mv prometheus.yml /etc/prometheus/prometheus.yml

sudo tee /etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP \$MAINPID
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
EOF

for i in rules rules.d files_sd; do sudo chown -R prometheus:prometheus /etc/prometheus/${i}; done
for i in rules rules.d files_sd; do sudo chmod -R 775 /etc/prometheus/${i}; done

# ----- dodanie targetów node export -------

lines=(
"  - job_name: "metrics_cpu_vm1""
""
"    static_configs:"
"      - targets: ["localhost:9100"]"
""
"  - job_name: "metrics_cpu_vm2""
""
"    static_configs:"
"      - targets: ["192.168.56.31:9100"]"
)

for line in "${lines[@]}"; do
  echo "$line" >> /etc/prometheus/prometheus.yml
done
# ------------------------------------------


sudo chown -R prometheus:prometheus /var/lib/prometheus/

sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus

systemctl status prometheus

sudo ufw allow 9090/tcp

#sudo sed -i 's/^# - "first_rules.yml"/- \/etc\/prometheus\/alert.rules.yml/' /etc/prometheus/prometheus.yml
