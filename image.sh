#!/usr/bin/env bash

IMAGE=vitorenesduarte/kuberlex

rebar3 release
docker build -t ${IMAGE} .
docker push ${IMAGE}
