FROM alpine:latest

RUN apk --update --no-cache add ca-certificates nginx
RUN apk add php7 php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-phar php7-fileinfo php7-mbstring php7-tokenizer

USER root
ENV  USER root
ENV HOME /etc/nginx/

WORKDIR /etc/nginx/

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]

RUN apk add --no-cache php7-imap && \
  mkdir -p setup && cd setup && \
  curl -sSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube.tar.gz && \
  tar -xf ioncube.tar.gz && \
  mv ioncube/ioncube_loader_lin_7.4.so /usr/lib/php7/modules/ && \
  echo 'zend_extension = /usr/lib/php7/modules/ioncube_loader_lin_7.4.so' >  /etc/php7/conf.d/00-ioncube.ini && \
  cd .. && rm -rf setup

USER nobody