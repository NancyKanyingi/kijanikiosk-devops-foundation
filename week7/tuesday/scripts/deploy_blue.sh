#!/bin/bash

set -e

APP_NAME="kijanikiosk"
BLUE_DIR="/opt/$APP_NAME/blue"
RELEASE_DIR="/opt/$APP_NAME/releases"

echo "Deploying application to BLUE environment..."

rm -rf "$BLUE_DIR/current"

mkdir -p "$BLUE_DIR/current"

cp -r "$RELEASE_DIR/latest/"* "$BLUE_DIR/current/"

echo "Blue deployment completed successfully."
