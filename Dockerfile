FROM php:8.2-fpm  
LABEL "language"="php"  
WORKDIR /var/www  
RUN apt-get update && apt-get install -y \  
    nginx \  
    curl \  
    && rm -rf /var/lib/apt/lists/*  
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www  
# 配置 PHP-FPM  
RUN echo 'output_buffering = 0' >> /usr/local/etc/php/conf.d/docker-php-ext-output.ini && \  
    echo 'memory_limit = 512M' >> /usr/local/etc/php/conf.d/docker-php-ext-output.ini && \  
    echo 'max_execution_time = 600' >> /usr/local/etc/php/conf.d/docker-php-ext-output.ini && \  
    echo 'default_charset = "UTF-8"' >> /usr/local/etc/php/conf.d/docker-php-ext-output.ini  
RUN cat <<'EOF' > /etc/nginx/sites-enabled/default  
server {  
    listen 8080;  
    root /var/www;  
    index litv2.php;  
    client_max_body_size 0;  
      
    # 增加 Nginx 缓冲  
    proxy_buffer_size 128k;  
    proxy_buffers 256 16k;  
    proxy_busy_buffers_size 256k;  
      
    location ~ \.php$ {  
        try_files $uri =404;  
        fastcgi_split_path_info ^(.+\.php)(/.*)$;  
        fastcgi_pass 127.0.0.1:9000;  
        fastcgi_index litv2.php;  
        include fastcgi_params;  
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;  
        fastcgi_param DOCUMENT_ROOT $realpath_root;  
        fastcgi_read_timeout 600s;  
        fastcgi_send_timeout 600s;  
        fastcgi_connect_timeout 600s;  
        fastcgi_buffer_size 256k;  
        fastcgi_buffers 512 32k;  
        fastcgi_busy_buffers_size 512k;  
        fastcgi_temp_file_write_size 512k;  
        fastcgi_max_temp_file_size 2048m;  
    }  
      
    location = / {  
        return 301 /litv2.php?token=cnbkk;  
    }  
      
    location /litv.php {  
        rewrite ^/litv.php(.*)$ /litv2.php$1 last;  
    }  
      
    location /litv2.php {  
        try_files $uri =404;  
        fastcgi_split_path_info ^(.+\.php)(/.*)$;  
        fastcgi_pass 127.0.0.1:9000;  
        fastcgi_index litv2.php;  
        include fastcgi_params;  
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;  
        fastcgi_param DOCUMENT_ROOT $realpath_root;  
        fastcgi_read_timeout 600s;  
        fastcgi_send_timeout 600s;  
        fastcgi_connect_timeout 600s;  
        fastcgi_buffer_size 256k;  
        fastcgi_buffers 512 32k;  
        fastcgi_busy_buffers_size 512k;  
        fastcgi_temp_file_write_size 512k;  
        fastcgi_max_temp_file_size 2048m;  
    }  
      
    location /proxy/ {  
        proxy_pass http://ntd-tgc.cdn.hinet.net/;  
        proxy_set_header Host ntd-tgc.cdn.hinet.net;  
        proxy_set_header User-Agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36";  
        proxy_set_header Referer "https://litv.tv/";  
        proxy_buffering off;  
        proxy_request_buffering off;  
        proxy_connect_timeout 10s;  
        proxy_send_timeout 300s;  
        proxy_read_timeout 300s;  
    }  
      
    location / {  
        try_files $uri $uri/ /litv2.php$is_args$args;  
    }  
      
    error_log /dev/stderr;  
    access_log /dev/stdout;  
}  
EOF  
COPY . /var/www  
RUN cd /var/www && ln -sf litv2.php litv.php  
RUN chown -R www-data:www-data /var/www  
EXPOSE 8080  
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]  
