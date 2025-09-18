#!/usr/bin/env bash
set -euo pipefail

AWS_REGION="${AWS_REGION:-ap-south-1}"
AWS_ACCOUNT="${AWS_ACCOUNT:-123456789012}"
ECR_REPO="${ECR_REPO:-hello-boot}"
APP_VER="${APP_VER:-1.0.0}"

aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com"
docker pull "$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:$APP_VER"
echo "Pulled image: $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:$APP_VER"
