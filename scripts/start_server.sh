#!/bin/bash
# Démarrer Apache et l'activer au démarrage
systemctl start httpd
systemctl enable httpd
sudo cp -r /home/ec2-user/club/* /var/www/html/
