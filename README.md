## Task Description 

Present, using the Vagrant environment, a monitoring system. The system should be deployed via bash scripts or Ansible role/playbook (provisioning). 
Requirements: 

● The system consists of two virtual machines. \
● The first virtual machine contains Prometheus, Alert manager, Grafana, and node exporter. \
● The second virtual machine contains only the node exporter. \
● The system should be automatically deployed from the host level (user’s computer), without the need for manual execution of any step on the virtual machines. \
● The task will be considered completed when, after performing provisioning from the host level (user’s computer), it will be possible to: \
○ log into the Grafana panel, add dashboards from the online library, and view metrics from both hosts, \
○ observe any alert, preferably on the Slack platform. \
● For the purposes of the task, the alert rules configuration can be set to a minimum, e.g., 5% CPU usage. \
