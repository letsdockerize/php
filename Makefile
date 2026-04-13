build: build-php-v6 build-php-v7

build-nc: build-php-v6-nc build-php-v7-nc

publish: publish-php-v6 publish-php-v7

DEV_DOCKERFILE ?= ./Dockerfile
PHP_VERSIONS ?= 8.3 8.2 8.1 8.0 7.4

DEPLOYER_V6_VERSION ?= 6.9.0
DEPLOYER_V6_SHA256 ?= aa07877cba8578c3fb70d1ab6ff82d5971a7dcf196d532cb14e1dd0f1c752d78
DEPLOYER_V7_VERSION ?= 7.5.12
DEPLOYER_V7_SHA256 ?= b55c6609653e888c672d327c407f8bba6324b9c9cc24f9dcfb3f4b3922760632

build-php: build-php-v6

build-php-nc: build-php-v6-nc

publish-php: publish-php-v6

build-php-v6:
	for v in $(PHP_VERSIONS); do \
		docker build -f ./Dockerfile \
			--build-arg PHP_TAG_VERSION=$$v \
			--build-arg DEPLOYER_VERSION=$(DEPLOYER_V6_VERSION) \
			--build-arg DEPLOYER_SHA256=$(DEPLOYER_V6_SHA256) \
			-t letsdockerize/php:$$v-dep6 .; \
		docker tag letsdockerize/php:$$v-dep6 letsdockerize/php:$$v; \
	done

build-php-v7:
	for v in $(PHP_VERSIONS); do \
		docker build -f ./Dockerfile \
			--build-arg PHP_TAG_VERSION=$$v \
			--build-arg DEPLOYER_VERSION=$(DEPLOYER_V7_VERSION) \
			--build-arg DEPLOYER_SHA256=$(DEPLOYER_V7_SHA256) \
			-t letsdockerize/php:$$v-dep7 .; \
	done

build-php-v6-nc:
	for v in $(PHP_VERSIONS); do \
		docker build --no-cache --pull -f ./Dockerfile \
			--build-arg PHP_TAG_VERSION=$$v \
			--build-arg DEPLOYER_VERSION=$(DEPLOYER_V6_VERSION) \
			--build-arg DEPLOYER_SHA256=$(DEPLOYER_V6_SHA256) \
			-t letsdockerize/php:$$v-dep6 .; \
		docker tag letsdockerize/php:$$v-dep6 letsdockerize/php:$$v; \
	done

build-php-v7-nc:
	for v in $(PHP_VERSIONS); do \
		docker build --no-cache --pull -f ./Dockerfile \
			--build-arg PHP_TAG_VERSION=$$v \
			--build-arg DEPLOYER_VERSION=$(DEPLOYER_V7_VERSION) \
			--build-arg DEPLOYER_SHA256=$(DEPLOYER_V7_SHA256) \
			-t letsdockerize/php:$$v-dep7 .; \
	done

publish-php-v6:
	for v in $(PHP_VERSIONS); do \
		docker push letsdockerize/php:$$v-dep6; \
		docker push letsdockerize/php:$$v; \
	done

publish-php-v7:
	for v in $(PHP_VERSIONS); do docker push letsdockerize/php:$$v-dep7; done

dev:
	for v in $(PHP_VERSIONS); do \
		docker build -f $(DEV_DOCKERFILE) --build-arg PHP_TAG_VERSION=$$v -t letsdockerize/php:$$v .; \
	done
