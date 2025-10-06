#!/bin/bash

kubectl create namespace petclinic

kubectl create secret docker-registry harbor-secret \
  --docker-server=8.221.96.197:80 \
  --docker-username=admin \
  --docker-password=Harbor12345 \
  -n petclinic
