FROM php:7.3-fpm

# Add composer
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer

# Add docker-php-extension-installer
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install missing extensions
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
	install-php-extensions bcmath bz2 calendar exif gd gettext intl mbstring mysqli opcache pcntl pdo_mysql soap sockets sodium sysvmsg sysvsem sysvshm xsl zip
	
# Use default configuration
#RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
