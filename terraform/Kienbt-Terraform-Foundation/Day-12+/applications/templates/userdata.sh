#!/bin/bash

apt-get update 
apt-get install -y git ansible 

mkdir /var/ansible-playbooks
git clone ${playbook_repository} /var/ansible-playbooks

ansible-playbook /var/ansible-playbooks -i /var/ansible-playbooks/hosts --extra-vars "wp_db_hostname=${wp_db_hostname} wp_db_name=${wp_db_name} wp_db_user=${wp_db_user} wp_db_password=${wp_db_password}"