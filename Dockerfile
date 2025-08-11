# Image officielle Apache + PHP
FROM php:8.2-apache

# Activer les modules Apache utiles
RUN a2enmod rewrite

# Copier les fichiers de ton projet dans le conteneur
COPY . /var/www/html/

# Donner les bons droits
RUN chown -R www-data:www-data /var/www/html

# Installer extensions PHP (ex : mysqli pour MySQL)
RUN docker-php-ext-install mysqli

# Activer output_buffering dans php.ini pour éviter les erreurs de session
RUN echo "output_buffering = 4096" >> /usr/local/etc/php/php.ini

# Exposer le port 80
EXPOSE 80
