#!/bin/bash
set -eux

# Refresh package list only
apt-get update -y

# Install Docker without interactive prompts
DEBIAN_FRONTEND=noninteractive \
  apt-get install -y docker.io

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Run PlantUML server
docker run -d \
  --restart=always \
  -p 8080:8080 \
  plantuml/plantuml-server:jetty
