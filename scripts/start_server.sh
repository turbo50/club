#!/bin/bash
set -e
echo "Installation des dépendances et dézippage du projet"

# Installer unzip si nécessaire
if ! command -v unzip &> /dev/null; then
  yum install -y unzip
fi

# Extraire le zip dans /var/www/html (racine du site Apache)
unzip -o /tmp/club.zip -d /var/www/html/

# Modifier les permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

echo "===== Redémarrage d'Apache ====="
sudo systemctl restart httpd
