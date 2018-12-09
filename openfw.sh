#!/bin/bash
apt update -y && apt upgrade -y
apt install ufw -y
ufw disable
ufw allow 9678
ufw allow 22/tcp
ufw limit 22/tcp
ufw logging on
ufw default deny incoming
ufw default allow outgoing
ufw --force enable
service ufw restart 
