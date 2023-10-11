build: build-php

build-nc: build-php-nc

publish: publish-php

build-php:
	docker build -f ./Dockerfile --build-arg PHP_TAG_VERSION=8.1 -t letsdockerize/php:8.1 .
	docker build -f ./Dockerfile --build-arg PHP_TAG_VERSION=8.0 -t letsdockerize/php:8.0 .
	docker build -f ./Dockerfile --build-arg PHP_TAG_VERSION=7.4 -t letsdockerize/php:7.4 .
	docker build -f ./Dockerfile --build-arg PHP_TAG_VERSION=7.3 -t letsdockerize/php:7.3 .
	docker build -f ./Dockerfile --build-arg PHP_TAG_VERSION=7.2 -t letsdockerize/php:7.2 .
	docker build -f ./Dockerfile --build-arg PHP_TAG_VERSION=7.1 -t letsdockerize/php:7.1 .
	docker build -f ./Dockerfile --build-arg PHP_TAG_VERSION=7.0 -t letsdockerize/php:7.0 .
	docker build -f ./Dockerfile --build-arg PHP_TAG_VERSION=5.6 -t letsdockerize/php:5.6 .

build-php-nc:
	docker build --no-cache --pull -f ./Dockerfile --build-arg PHP_TAG_VERSION=8.1 -t letsdockerize/php:8.1 .
	docker build --no-cache --pull -f ./Dockerfile --build-arg PHP_TAG_VERSION=8.0 -t letsdockerize/php:8.0 .
	docker build --no-cache --pull -f ./Dockerfile --build-arg PHP_TAG_VERSION=7.4 -t letsdockerize/php:7.4 .
	docker build --no-cache --pull -f ./Dockerfile --build-arg PHP_TAG_VERSION=7.3 -t letsdockerize/php:7.3 .
	docker build --no-cache --pull -f ./Dockerfile --build-arg PHP_TAG_VERSION=7.2 -t letsdockerize/php:7.2 .
	docker build --no-cache --pull -f ./Dockerfile --build-arg PHP_TAG_VERSION=7.1 -t letsdockerize/php:7.1 .
	docker build --no-cache --pull -f ./Dockerfile --build-arg PHP_TAG_VERSION=7.0 -t letsdockerize/php:7.0 .
	docker build --no-cache --pull -f ./Dockerfile --build-arg PHP_TAG_VERSION=5.6 -t letsdockerize/php:5.6 .

publish-php:
	docker push letsdockerize/php:8.1
	docker push letsdockerize/php:8.0
	docker push letsdockerize/php:7.4
	docker push letsdockerize/php:7.3
	docker push letsdockerize/php:7.2
	docker push letsdockerize/php:7.1
	docker push letsdockerize/php:7.0
	docker push letsdockerize/php:5.6

dev:
	docker build -f ./Dockerfile-dev --build-arg PHP_TAG_VERSION=8.1 -t letsdockerize/php:8.1 .
	docker build -f ./Dockerfile-dev --build-arg PHP_TAG_VERSION=8.0 -t letsdockerize/php:8.0 .
	docker build -f ./Dockerfile-dev --build-arg PHP_TAG_VERSION=7.0 -t letsdockerize/php:7.4 .
	docker build -f ./Dockerfile-dev --build-arg PHP_TAG_VERSION=7.1 -t letsdockerize/php:7.3 .
	docker build -f ./Dockerfile-dev --build-arg PHP_TAG_VERSION=7.2 -t letsdockerize/php:7.2 .
	docker build -f ./Dockerfile-dev --build-arg PHP_TAG_VERSION=7.3 -t letsdockerize/php:7.1 .
	docker build -f ./Dockerfile-dev --build-arg PHP_TAG_VERSION=7.4 -t letsdockerize/php:7.0 .
	docker build -f ./Dockerfile-dev --build-arg PHP_TAG_VERSION=5.6 -t letsdockerize/php:5.6 .
