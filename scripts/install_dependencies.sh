#!/bin/bash
# Arrêt du script si une commande échoue
set -e

echo "===== Mise à jour des paquets ====="
sudo yum update -y

echo "===== Installation d'Apache et PHP ====="
sudo amazon-linux-extras enable php8.0
sudo yum install -y php php-cli php-common php-mbstring php-xml httpd

echo "===== Activation et démarrage d'Apache ====="
sudo systemctl enable httpd
sudo systemctl start httpd

echo "===== Nettoyage du répertoire web ====="
sudo rm -rf /var/www/html/*
