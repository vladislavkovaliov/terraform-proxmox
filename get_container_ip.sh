#!/bin/bash

CONTAINER_ID=$1
PROXMOX_HOST="__ip__"
PROXMOX_USER="__user__"
PROXMOX_PASSWORD="__password__"

IP=$(sshpass -p $PROXMOX_PASSWORD ssh -o StrictHostKeyChecking=no $PROXMOX_USER@$PROXMOX_HOST "pct exec $CONTAINER_ID -- ip a | grep 'inet ' | grep -v '127.0.0.1' | awk '{print \$2}' | cut -d/ -f1")

echo $IP

sshpass -p $PROXMOX_PASSWORD ssh -o StrictHostKeyChecking=no root@$IP << 'EOF'
apk update
apk add openssh

if [ ! -f /etc/ssh/sshd_config ]; then
    cp /etc/ssh/sshd_config.default /etc/ssh/sshd_config
fi

echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

service sshd restart
EOF


echo $IP
echo 42