# mangapie-docker

Run [mangapie](https://github.com/pierobot/mangapie) in docker with compose.

## Setup

### docker-compose
Install docker compose through pip, pip3, or the [alternative methods](https://docs.docker.com/compose/install/#install-compose).

```bash
pip3 install docker-compose
```

### Manga

Add directories to the ``manga`` directory.  
**Note**: Unfortunately, docker does not allow you to use symbolic links inside volumes.

### Certificates

Create the required TLS certificates.  
**Note:** The command below will generate a self-signed certificate **but** **no** certificate authority.

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx/certs/mangapie.key -out nginx/certs/mangapie.crt
```

### Build Containers

Build and start the containers. This will take a while the first time.  

```bash
docker-compose build
docker-compose up
```

**Note**: The supervisor container will have its workers exit the very first run. It is safe to ignore.  

Install mangapie and restart the containers.
```bash
docker exec -it mangapie.php7-fpm mangapie install
docker-compose down
docker-compose up
```

If you ever need to update the actual mangapie code, use the following:  
```bash
docker exec -it mangapie.php7-fpm mangapie update
```

Finally, load up the site in your browser, sign in using "dev", for the username, and "dev" for the password.

### Things to  consider
* These containers use 3390 for the user and group IDs. If you will be adding directories and files from other containers, they must have the appropriate permissions.
    * If those containers allow you to set a UID and GUID then consider doing so. 
* Symbolic links to the host will not work inside containers.
