FROM debian
RUN apt-get update && apt-get -y install php-fpm php-mysql default-mysql-client cron
RUN apt-get -y install php-cli unzip curl php-gd php-xml php-zip php-mbstring php-curl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY . /app

RUN composer update
RUN composer install

RUN php artisan migrate
RUN php artisan key:generate --force

CMD php artisan serve --host 0.0.0.0 --port=8000
EXPOSE 8000
