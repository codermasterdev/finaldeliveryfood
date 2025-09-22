# Usa uma imagem base do PHP com FPM para Nginx
FROM php:8.2-fpm-alpine

# Instala extensões PHP e dependências.
# A extensão 'gd' é importante para manipulação de imagens (logos de restaurantes, etc.)
RUN apk add --no-cache \
    mysql-client \
    libzip-dev \
    icu-dev \
    jpeg-dev \
    png-dev \
    freetype-dev \
    git \
    && docker-php-ext-install \
    mysqli \
    pdo_mysql \
    gd \
    mbstring \
    zip \
    exif \
    intl \
    opcache \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && rm -rf /var/cache/apk/*

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho
WORKDIR /var/www/html

# Copia TODOS os arquivos do projeto para o diretório de trabalho do container
COPY . .

# Dá permissão para o servidor web escrever nas pastas necessárias
# A pasta 'uploads' e 'uploads-temp' são essenciais para o funcionamento do script
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/uploads /var/www/html/uploads-temp

# Expor a porta 9000 para o PHP-FPM
EXPOSE 9000

# Comando para iniciar o PHP-FPM
CMD ["php-fpm"]
