# Usamos uma imagem base oficial do PHP 7.4 com FPM, baseada em Alpine Linux (super leve)
FROM php:7.4-fpm-alpine

# Instala as dependências necessárias: Nginx, Git e extensões comuns do PHP
RUN apk update && apk add --no-cache \
    nginx \
    git \
    libzip-dev \
    libpng-dev \
    jpeg-dev \
    freetype-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli zip pdo pdo_mysql

# Define o diretório de trabalho dentro do container
WORKDIR /var/www/html

# Copia a configuração customizada do Nginx para dentro da imagem
COPY .docker/nginx/default.conf /etc/nginx/http.d/default.conf

# Copia o script de inicialização para dentro da imagem e o torna executável
COPY .docker/start.sh /start.sh
RUN chmod +x /start.sh

# Copia todos os arquivos do seu projeto para o diretório de trabalho
COPY . .

# Garante que o servidor web tenha permissão para escrever nas pastas necessárias
RUN chown -R www-data:www-data /var/www/html/uploads \
    && chown -R www-data:www-data /var/www/html/uploads-temp \
    && chown -R www-data:www-data /var/www/html/cpanel \
    && chown -R www-data:www-data /var/www/html/configs

# Expõe a porta 80, que é a porta padrão para web
EXPOSE 80

# Comando que será executado quando o container iniciar
CMD ["/start.sh"]
