# Basic golang+caddy setup

This repository can be used as a template for https Golang apps, the net.http server is not directly used for SSL by Golang.

Instead, caddy (a Golang project) manages SSL for us and allows us to use SSL by default without the normal SSL debugging.

# Setup

```bash
docker compose build
docker volume create caddy_data # Create external volume
# Change the Caddy configuration (host.example.com -> your host)
docker compose up -d # Run detached
docker compose logs -f # To view the logs.
```