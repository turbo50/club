#!/bin/bash
set -e
# Démarrer Apache et l'activer au démarrage
systemctl start httpd
systemctl enable httpd
sudo cp -r /home/ec2-user/club/* /var/www/html/
echo "===== Attribution des permissions ====="
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

echo "===== Redémarrage d'Apache ====="
sudo systemctl restart httpd
