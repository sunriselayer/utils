#!/bin/bash
# // This script generates an nginx configuration for the sunrise application.
# //
# // Overview:
# // This script creates/overwrites the nginx configuration file for the application.
# // It reads the server name from a 'sunrise.env' file located in the same directory.
# //
# // Specifications:
# // - A 'sunrise.env' file must exist in the same directory as this script.
# // - The 'sunrise.env' file must contain a SERVER_NAME variable (e.g., SERVER_NAME="your.domain.com").
# // - The script must be run with sudo privileges to write to /etc/nginx/conf.d/.
# //
# // Limitations:
# // - This script assumes that SSL certificates for the given server name are
# //   available at /etc/letsencrypt/live/SERVER_NAME/.

set -eu

if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo." >&2
  exit 1
fi

# Source the configuration file
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SERVER_NAME="sunrise-dawn-1.cauchye.com"

if [ -z "${SERVER_NAME-}" ]; then
    echo "Error: SERVER_NAME is not set or is empty in ${CONFIG_FILE}." >&2
    exit 1
fi

OUTPUT_FILE="/etc/nginx/conf.d/sunrise.conf"

rm -f "${OUTPUT_FILE}"

cat > "${OUTPUT_FILE}" << EOF
#for faucet
server {
        listen 8001 ssl;
        server_name ${SERVER_NAME};
        ssl_certificate /etc/letsencrypt/live/${SERVER_NAME}/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/${SERVER_NAME}/privkey.pem;


        # for redirct http to https
        # error_page 497 301 =307 https://:;
        location / {
                proxy_pass http://127.0.0.1:8000;
                proxy_http_version 1.1;
                # for redirct http to https
                #proxy_redirect off;
                #proxy_set_header Host :;
                #proxy_set_header X-Forwarded-For ;
                #proxy_set_header X-Forwarded-Ssl on;
        }
}

server {
        listen 8003 ssl;
        server_name ${SERVER_NAME};
        ssl_certificate /etc/letsencrypt/live/${SERVER_NAME}/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/${SERVER_NAME}/privkey.pem;


        # for redirct http to https
        # error_page 497 301 =307 https://:;
        location / {
                proxy_pass http://127.0.0.1:8002;
                proxy_http_version 1.1;
                # for redirct http to https
                #proxy_redirect off;
                #proxy_set_header Host :;
                #proxy_set_header X-Forwarded-For ;
                #proxy_set_header X-Forwarded-Ssl on;
        }
}


  server {
    listen 8000;
    listen [::]:8000;
    server_name localhost;
    charset UTF-8;

    location / {
      proxy_http_version 1.1;
      proxy_pass http://localhost:7000;

      if (\$request_method = 'OPTIONS') {
        add_header Access-Control-Allow-Origin '*';
        add_header Access-Control-Allow-Methods 'GET, POST, PUT, DELETE';
        add_header Access-Control-Allow-Headers 'Origin, Authorization, Accept, Content-Type';
        # add_header Access-Control-Max-Age 3600;
        add_header Content-Type 'text/plain charset=UTF-8';
        add_header Content-Length 0;
        return 204;
      }
    }
  }

  server {
    listen 8002;
    listen [::]:8002;
    server_name localhost;
    charset UTF-8;

    location / {
      proxy_http_version 1.1;
      proxy_pass http://localhost:7002;

      if (\$request_method = 'OPTIONS') {
        add_header Access-Control-Allow-Origin '*';
        add_header Access-Control-Allow-Methods 'GET, POST, PUT, DELETE';
        add_header Access-Control-Allow-Headers 'Origin, Authorization, Accept, Content-Type';
        # add_header Access-Control-Max-Age 3600;
        add_header Content-Type 'text/plain charset=UTF-8';
        add_header Content-Length 0;
        return 204;
      }
    }
  }


server {
        listen 3040 ssl;
        server_name ${SERVER_NAME};
        ssl_certificate /etc/letsencrypt/live/${SERVER_NAME}/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/${SERVER_NAME}/privkey.pem;


        # for redirct http to https
        # error_page 497 301 =307 https://:;
        location / {
              proxy_pass http://127.0.0.1:3030;
              proxy_http_version 1.1;
#	      if (\$request_method = 'OPTIONS') {
		add_header Access-Control-Allow-Origin '*';
		add_header Access-Control-Allow-Methods 'GET, POST, PUT, DELETE';
		add_header Access-Control-Allow-Headers 'Origin, Authorization, Accept, Content-Type';
		# add_header Access-Control-Max-Age 3600;
		add_header Content-Type 'text/plain charset=UTF-8';
		add_header Content-Length 0;
		return 204;
#	      }
        }
}


#for rpc api endpoint
server {
        listen 443 ssl;
        server_name ${SERVER_NAME};
        ssl_certificate /etc/letsencrypt/live/${SERVER_NAME}/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/${SERVER_NAME}/privkey.pem;


        # for redirct http to https
        # error_page 497 301 =307 https://\$host:\$server_port\$request_uri;
        location / {
                proxy_pass http://127.0.0.1:26657;
                proxy_http_version 1.1;
                # for redirct http to https
                #proxy_redirect off;
                #proxy_set_header Host \$host:\$server_port;
                #proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                #proxy_set_header X-Forwarded-Ssl on;
                add_header 'Access-Control-Allow-Origin' '*';
                add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
                add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range';
                add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range';
        }
}

# for rest endpoint
server {
        listen 1318 ssl;
        server_name ${SERVER_NAME};
        ssl_certificate /etc/letsencrypt/live/${SERVER_NAME}/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/${SERVER_NAME}/privkey.pem;


        # for redirct http to https
        # error_page 497 301 =307 https://:;
        location / {
                proxy_pass http://127.0.0.1:1317;
                proxy_http_version 1.1;
                # for redirct http to https
                #proxy_redirect off;
                #proxy_set_header Host :;
                #proxy_set_header X-Forwarded-For ;
                #proxy_set_header X-Forwarded-Ssl on;
        }
}

server {
        listen 9092 ssl;
        server_name ${SERVER_NAME};
        ssl_certificate /etc/letsencrypt/live/${SERVER_NAME}/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/${SERVER_NAME}/privkey.pem;


        # for redirct http to https
        # error_page 497 301 =307 https://:;
        location / {
                proxy_pass http://127.0.0.1:9090;
                proxy_http_version 1.1;
                # for redirct http to https
                #proxy_redirect off;
                #proxy_set_header Host :;
                #proxy_set_header X-Forwarded-For ;
                #proxy_set_header X-Forwarded-Ssl on;
        }
}
EOF

echo "Successfully created ${OUTPUT_FILE}"

echo "Restarting nginx"
sudo systemctl restart nginx