FROM php:8.3-fpm

# Instalador de extensiones
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Instalación: Dependencias sistema + Extensiones PHP
RUN chmod +x /usr/local/bin/install-php-extensions && \
    apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    imagemagick \
    unixodbc \
    unixodbc-dev \
    && \
    install-php-extensions \
    xdebug \
    mbstring \
    gd \
    dba \
    odbc \
    mysqli \
    pdo_odbc \
    pdo_mysql \
    zip \
    intl \
    exif \
    imagick

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configuración PHP para subida de archivos (Sincronizado con apache.Dockerfile)
RUN echo "upload_max_filesize = 10M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "post_max_size = 20M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "max_file_uploads = 20" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "memory_limit = 256M" >> /usr/local/etc/php/conf.d/uploads.ini 

# Ajuste de usuario
# RUN usermod -u 1000 www-data

WORKDIR /var/www/html
