#!/bin/bash

yum install ansible -y
cd /tmp
git clone https://github.com/dbramanayanam/Projectwork.git
cd Projectwork/ansible-roles/
ansible-playbook -e component=mongodb main.yaml
ansible-playbook -e component=redis main.yaml
ansible-playbook -e component=rabbitmq main.yaml
ansible-playbook -e component=mysql main.yaml
ansible-playbook -e component=catalogue main.yaml
ansible-playbook -e component=user main.yaml
ansible-playbook -e component=cart main.yaml
ansible-playbook -e component=shipping main.yaml
ansible-playbook -e component=payment main.yaml
ansible-playbook -e component=dispatch main.yaml
ansible-playbook -e component=web main.yaml