#!/bin/bash
set -e

echo "===== Détection de la version Amazon Linux ====="
OS_VERSION=$(cat /etc/os-release | grep VERSION_ID | cut -d '"' -f 2)

if [[ "$OS_VERSION" == "2" ]]; then
    echo "Amazon Linux 2 détecté"
    sudo yum update -y
    sudo amazon-linux-extras enable php8.0
    sudo yum install -y php php-cli php-common php-mbstring php-xml httpd
elif [[ "$OS_VERSION" == "2023" ]]; then
    echo "Amazon Linux 2023 détecté"
    sudo dnf update -y
    sudo dnf install -y php-cli php-common php-mbstring php-xml httpd
else
    echo "Version Amazon Linux inconnue : $OS_VERSION"
    exit 1
fi

echo "===== Activation et démarrage d'Apache ====="
sudo systemctl enable httpd
sudo systemctl start httpd

echo "===== Nettoyage du répertoire web ====="
sudo rm -rf /var/www/html/*
