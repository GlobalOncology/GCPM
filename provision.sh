#!/usr/bin/env bash
apt-get update

#install any binaries for compiling from source
apt-get install -y build-essential

#install apache utilities
apt-get install -y apache2-utils

#install git-scm
apt-get install -y git

#install utilities
apt-get install -y unzip

#needed for passenger
apt-get install -y libcurl4-openssl-dev

#install php
apt-get install -y

apt-get install -y memcached

sudo timedatectl set-timezone America/New_York

#install node
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install -y nodejs

gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --rails
source /usr/local/rvm/scripts/rvm

rvm install 2.3.1
rvm use 2.3.1 --default
gem install rails --version 4.1.4 --no-rdoc --no-ri
apt-get install -y postgresql-common postgresql-9.3 libpq-dev exim4-daemon-light mailutils

gem install passenger

sudo apt-get install -y dirmngr gnupg
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates

# Add our APT repository
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

# Install Passenger + Nginx
sudo apt-get install -y nginx-extras passenger

#dpkg-reconfigure exim4-config


cd /var/www

cat << EOF > /etc/nginx/nginx.conf
worker_processes  1;

events {
    worker_connections  1024;
}


http {
    include /etc/nginx/passenger.conf;

    include       mime.types;
    default_type  application/octet-stream;
    client_max_body_size 100m;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       80  default_server;
        server_name  _; # some invalid name that won't match anything
        return       444;
    }

    server {
        listen       80;
        server_name  thegomap.dev;
        passenger_enabled on;
	    root /var/www/public;
	    #rewrite ^/$ http://www.thegomap.org permanent;
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }

}

EOF

sudo service nginx restart

#if [ -f /etc/nginx/sites-enabled/default ] ; then
#    rm /etc/nginx/sites-enabled/default
#fi

grep "cd /var/www" /home/vagrant/.bashrc || printf "cd /var/www\n" >> /home/vagrant/.bashrc

# set the password for postgres to postgres
sudo -u postgres psql --command "ALTER USER postgres WITH PASSWORD 'postgres';"

echo 'host    all             all             all                     md5' >> /etc/postgresql/9.3/main/pg_hba.conf
echo "listen_addresses = '*'" >> /etc/postgresql/9.3/main/postgresql.conf

sudo service postgresql restart

cd /var/www
gem install bundler && bundle install

cat << EOF > /var/www/.env
RAKE_ENV=development
RAILS_ENV=development
PORT=3000

GCPM_DATABASE_USER=postgres
GCPM_DATABASE_PASSWORD=postgres
GCPM_DATABASE_HOST=localhost
GCPM_DATABASE_URL=

DEVISE_KEY=
SECRET_KEY_BASE=

CARTODB_KEY=
CARTODB_ACCOUNT=

SENDGRID_USERNAME=
SENDGRID_PASSWORD=

GMAIL_DOMAIN=gmail.com
GMAIL_USERNAME=xxx@gmail.com
GMAIL_PASSWORD=xxx
EMAIL=xxx@zzz.com

BASEMAP_URL=http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png

GOOGlE_ANALYTICS=
EOF

echo "passenger_friendly_error_pages on;" >> /etc/nginx/passenger.conf
echo "rails_env development;" >> /etc/nginx/passenger.conf

# for some reason these images are not readable and need to be
chmod -R 777 /usr/local/rvm/gems/ruby-2.3.1@gcpm-v2/gems/rails_db-1.3.3/app/assets/images/

service nginx restart

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake db:geo
bundle exec rake events:create
bundle exec rake layers:import



