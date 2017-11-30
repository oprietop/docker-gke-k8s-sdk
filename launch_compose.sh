#!/bin/sh
docker-compose pull
docker-compose run sdk
docker-compose down
