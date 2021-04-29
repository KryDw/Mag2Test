#!/bin/bash

# Download magento2
function magento_dl {
	echo "Downloading magento v2.3.5"
	mkdir -p www
	wget -c -q https://github.com/magento/magento2/archive/refs/tags/2.3.5-p2.tar.gz -O - | tar -xz -C www && mv www/magento2-2.3.5-p2 www/magento2
}

# Fix permission
function magento_permission_fix {
	echo "Fixing magento permission... "
	docker-compose exec php-fpm /bin/bash -c "cd magento2 && \
		find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} + && \
		find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} + && \
		chown -R :www-data . && \
		chmod u+x bin/magento"
	echo "Done"
}

# Setup magento2
function magento_setup {
	echo "Configuring magento"
	docker-compose exec php-fpm /bin/bash -c "cd magento2 && \
		composer install && \
		bin/magento setup:install \
		--backend-frontname=admin \
		--admin-user='admin' \
		--admin-password='admin123' \
		--admin-email='admin@admin.com' \
		--admin-firstname='admin' \
		--admin-lastname='admin' \
		--db-host=mysql \
		--db-name=magento \
		--db-user=magento \
		--db-password=magento123 \
		--cache-backend=redis \
		--cache-backend-redis-server=redis-cache \
		--cache-backend-redis-port=6380 \
		--session-save=redis \
		--session-save-redis-host=redis-session \
		--session-save-redis-port=6390"
}

# Check if magento2 arleady exist
if [[ -d "www/magento2" ]]; then
	echo "Magento2 files arleady exist."
	echo "Do you want to configure new one?"
	read -p "[Y]es/[N]o (default: no): " -r ANSWER
	if [[ "$ANSWER" =~ ^[Yy]$ ]]; then
		echo "Creating backup"
		mkdir -p backup
		mv "www" "backup/www $(date +'(%Y-%m-%d %H-%M-%S)')"
	else
		exit 1
	fi
fi

magento_dl
docker-compose up -d
magento_permission_fix
magento_setup
docker-compose down

exit
