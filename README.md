# mangapie-docker
Run [mangapie](https://github.com/pierobot/mangapie) in docker with compose.

## Setup
Install docker compose through pip, pip3, or the [alternative methods](https://docs.docker.com/compose/install/#install-compose).
```
pip3 install docker-compose
```
Clone the repository, mangapie, and create the .env file we need.
```
git clone https://github.com/pierobot/mangapie-docker && cd mangapie-docker
git clone https://github.com/pierobot/mangapie www/mangapie
cp www/mangapie/.env.example /www/mangapie/.env
```

Edit the appropriate APP and DB fields in the .env file.  
Be sure to enter the **correct** IPs and that the ports are not already in use.

Create the required TLS certificates.  
**Note:** The command below will generate a self-signed certificate **but** **no** certificate authority.
```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx/certs/mangapie.key -out nginx/certs/mangapie.crt
```

## Usage
Build: ``docker-compose build``  
Run (detached): ``docker-compose up -d``  
Stop: ``docker-compose down``  

After building and running, run the init script through the php container.
```
docker exec php_container sh -c "./mangapie-init.sh"
```

Unless I'm forgetting something, that should be it. :thinking:
