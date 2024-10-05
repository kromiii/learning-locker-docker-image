# Learning Locker Docker Image

This repository contains a Docker image for [Learning Locker](https://github.com/LearningLocker/learninglocker).

## Features

- Multi-architecture support (AMD64, ARM64)
- Published on GitHub Container Registry (ghcr)

## Quick Start

To run Learning Locker using docker-compose:

1. Clone this repository
2. Run the following command:

```bash
docker-compose up -d
```

Learning Locker will be available at `http://localhost:3000`.

## Building Locally

If you want to build the image locally:

```bash
docker compose build learninglocker
```

## Initial Setup

### Creating an Admin User

To create an admin user for Learning Locker, use the following command:

```bash
EMAIL_ADDRESS=admin@example.com
ORGANIZATION=personal
PASSWORD=password123
docker exec \
 -e EMAIL_ADDRESS=${EMAIL_ADDRESS} \
 -e ORGANIZATION=${ORGANIZATION} \
 -e PASSWORD=${PASSWORD} learninglocker bash -c '\
    source ~/.bashrc;
    node ./cli/dist/server createSiteAdmin "${EMAIL_ADDRESS}" "${ORGANIZATION}" "${PASSWORD}"'
```

### Logging In

1. Navigate to Learning Locker (http://localhost:3000/)
2. Log in with the admin account you just created
3. Select your organization

### Creating an LRS (Learning Record Store)

1. Go to `Settings > Stores` in the side menu
2. Create an LRS with a name of your choice

### Configuring a Client

1. Go to `Settings > Clients` in the side menu
2. Select `New xAPI store client`
3. Ensure the LRS you created is selected in the `LRS (optional)` field
4. Check the `API All` box under `Overall Scopes`

## Image Information

The Docker image is available on GitHub Container Registry:

https://github.com/kromiii/learning-locker-docker-image/pkgs/container/learninglocker

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT
