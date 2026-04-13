[![GitHub CI](https://github.com/letsdockerize/php/actions/workflows/ci.yml/badge.svg)](https://github.com/letsdockerize/php/actions/workflows/ci.yml)

# Let's Dockerize - PHP

[Docker Hub Repository](https://hub.docker.com/r/letsdockerize/php)

Prebuilt Docker images for multiple PHP versions.

## Supported PHP Tags

- 8.3
- 8.2
- 8.1
- 8.0
- 7.4

## Local Build Commands

Build all supported tags:

make build

Force clean rebuild for all supported tags:

make build-nc

Push all supported tags to Docker Hub:

make publish

Build using the development target:

make dev

By default, make dev uses ./Dockerfile.
You can override it with DEV_DOCKERFILE when needed:

make dev DEV_DOCKERFILE=./Dockerfile.custom

## Single Version Build Example

Build only one version directly with Docker:

docker build -f Dockerfile --build-arg PHP_TAG_VERSION=8.3 -t letsdockerize/php:8.3 .

Optional build arguments:

- COMPOSER_VERSION (default: 2.9.5)
- DEPLOYER_VERSION (default: 7.5.12)
- DEPLOYER_SHA256 (pinned checksum for the selected Deployer version)

Example:

docker build -f Dockerfile \
	--build-arg PHP_TAG_VERSION=8.3 \
	--build-arg COMPOSER_VERSION=2.9.5 \
	--build-arg DEPLOYER_VERSION=7.5.12 \
	--build-arg DEPLOYER_SHA256=b55c6609653e888c672d327c407f8bba6324b9c9cc24f9dcfb3f4b3922760632 \
	-t letsdockerize/php:8.3 .

## CI Behavior

GitHub Actions builds all supported PHP tags for push and pull request events.
Docker push is enabled only when the workflow runs on the repository default branch and the event is not a pull request.

## FAQ

Why is the first build slow?

- The first run needs to download base image layers and apt packages.
- Later builds are much faster because Docker layer cache is reused.
- If you run make build-nc, cache is intentionally bypassed.

How do I build only one PHP version?

- Use Docker directly with one PHP_TAG_VERSION value.

docker build -f Dockerfile --build-arg PHP_TAG_VERSION=8.2 -t letsdockerize/php:8.2 .

How do I override DEPLOYER_SHA256 safely?

- Only override it when you also change DEPLOYER_VERSION.
- Always fetch checksum from a trusted release source before building.
- Pass both values together to keep integrity validation meaningful.

docker build -f Dockerfile \
	--build-arg PHP_TAG_VERSION=8.3 \
	--build-arg DEPLOYER_VERSION=7.5.12 \
	--build-arg DEPLOYER_SHA256=b55c6609653e888c672d327c407f8bba6324b9c9cc24f9dcfb3f4b3922760632 \
	-t letsdockerize/php:8.3 .
