# Basic golang+caddy setup

This repository can be used as template for https golang apps,
the net.http server is not directly used for ssl from golang. 

Instead, caddy(a golang project) manages the ssl stuff for us and allows us for
ssl per default without the normal ssl troubleshooting (over letsencrypt).


# Setup

```bash
docker compose build
docker volume create caddy_data # Create external volume
# Change the Caddy configuration (host.example.com -> your host)
docker compose up -d # Run detached
docker compose logs -f # To view the logs.
```