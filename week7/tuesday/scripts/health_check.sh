#!/bin/bash

set -e

HEALTH_URL="http://localhost:3000/health"

echo "Checking application health..."

if curl --silent --fail "$HEALTH_URL" >/dev/null; then
    echo "Application is healthy."
    exit 0
else
    echo "Application health check failed."
    exit 1
fi
