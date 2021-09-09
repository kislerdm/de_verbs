SHELL := /bin/bash

DIR_DATA := $(PWD)/data
DATA_URL := https://www.korrekturen.de/flexion/download

help: ## Prints help message.
	@ grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1m%-30s\033[0m %s\n", $$1, $$2}'

download: ## Downloads data from the source.
	@ test -d $(DIR_DATA) || mkdir $(DIR_DATA)
	@ curl -o $(DIR_DATA)/verben.sql.gz $(DATA_URL)/verben.sql.gz
	# @ curl -o $(DIR_DATA)/nomen.sql.gz $(DATA_URL)/nomen.sql.gz
	# @ curl -o $(DIR_DATA)/adjektive.sql.gz $(DATA_URL)/adjektive.sql.gz

setup-db: ## Setup the db.
	@ docker pull --platform linux/amd64 mysql:8.0
	@ docker run -d \
		--name dict \
		-e MYSQL_USER=admin \
		-e MYSQL_ROOT_PASSWORD=admin \
		-e MYSQL_PASSWORD=admin \
		-e MYSQL_DATABASE=dictionary \
		-v $(DIR_DATA):/docker-entrypoint-initdb.d \
		-it mysql:8.0

setup: download setup-db ## Setups the db and fills with downloaded data dump

connect: ## Connect to the db from inside the container.
	@ docker exec -it dict /bin/bash

.DEFAULT_GOAL := help
