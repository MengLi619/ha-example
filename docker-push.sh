#!/usr/bin/env bash

docker tag mengli/ha-example/mysql-group-replication:latest registry.cn-beijing.aliyuncs.com/mengli/ha-example_mysql-group-replication:latest
docker tag mengli/ha-example/redis-sentinel:latest registry.cn-beijing.aliyuncs.com/mengli/ha-example_redis-sentinel:latest
docker tag mengli/ha-example/ha-example-server:latest registry.cn-beijing.aliyuncs.com/mengli/ha-example_ha-example-server:latest

docker push registry.cn-beijing.aliyuncs.com/mengli/ha-example_mysql-group-replication:latest
docker push registry.cn-beijing.aliyuncs.com/mengli/ha-example_redis-sentinel:latest
docker push registry.cn-beijing.aliyuncs.com/mengli/ha-example_ha-example-server:latest