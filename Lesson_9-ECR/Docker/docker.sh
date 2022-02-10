#!/bin/bash

# Login to AWS
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${registry_id}.dkr.ecr.${region}.amazonaws.com

# Build container
docker build -t ${registry_id}.dkr.ecr.${region}.amazonaws.com/${app_name}:${image_tag} .

# Push container to AWS
docker push ${registry_id}.dkr.ecr.${region}.amazonaws.com/${app_name}:${image_tag}