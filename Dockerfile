# Use an official PHP runtime as a parent image
FROM php:8.3-fpm

# Set the working directory in the container
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql intl gd zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Clone your Symfony project from your Git repository
RUN git clone https://github.com/jasperdeklijn/sitionconnect.git .

# Install Symfony dependencies
RUN composer install --no-scripts

# Expose port 8000 to the outside world
EXPOSE 8000

# Run the Symfony application
CMD ["php", "bin/console", "server:run", "0.0.0.0:8000"]