#!/bin/bash

set -e

APP_NAME="kijanikiosk"
GREEN_DIR="/opt/$APP_NAME/green"
RELEASE_DIR="/opt/$APP_NAME/releases"

echo "Deploying application to GREEN environment..."

rm -rf "$GREEN_DIR/current"

mkdir -p "$GREEN_DIR/current"

cp -r "$RELEASE_DIR/latest/"* "$GREEN_DIR/current/"

echo "Green deployment completed successfully."
