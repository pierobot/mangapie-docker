# mangapie-docker

Run [mangapie](https://github.com/pierobot/mangapie) in docker with compose.

## Setup

### docker-compose
Install docker compose through pip, pip3, or the [alternative methods](https://docs.docker.com/compose/install/#install-compose).

```bash
pip3 install docker-compose
```

### Manga

Add directories to the ``manga/manga`` directory.  
**Note**: Unfortunately, docker does not allow you to use symbolic links inside volumes.

### Certificates

Create the required TLS certificates.  
**Note:** The command below will generate a self-signed certificate **but** **no** certificate authority.

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx/certs/mangapie.key -out nginx/certs/mangapie.crt
```

### mangapie
Clone the repository, mangapie, and create the .env file we need.

```bash
git clone https://github.com/pierobot/mangapie-docker && cd mangapie-docker
git clone https://github.com/pierobot/mangapie www/mangapie
cp www/mangapie/.env.example www/mangapie/.env
```

### Build Containers

Build and start the containers (This will take a while the first time)

```bash
docker-compose up
```

### Edit .env

Edit the appropriate **APP_** and **DB_** fields in the .env file.  
Be sure to enter the **correct** IP/hostname and that the ports are not already in use.

You can get the IP of the database container using

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mangapie.mariadb
```

### Initialize

Finally, run the init script which will take care of creating an app key and seeding the database.

```bash
docker exec mangapie.php7-fpm sh -c "./mangapie-init.sh"
```

### Updating

If you ever wish to update mangapie, simply run the update script.

```bash
docker exec mangapie.php7-fpm sh -c "./mangapie-update.sh"
```
