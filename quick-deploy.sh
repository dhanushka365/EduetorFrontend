#!/bin/bash

# Quick deployment script for immediate use
# Run this script on your Oracle VM after copying files

echo "🚀 Eduetor Frontend - Quick Deploy"
echo "=================================="

# Configuration
APP_DIR="/var/www/html/eduetor"
TEMP_DIR="/tmp/eduetor-deployment"

# Check if temp directory exists
if [ ! -d "$TEMP_DIR" ]; then
    echo "❌ No deployment files found in $TEMP_DIR"
    echo "Please copy your built files to $TEMP_DIR first"
    exit 1
fi

# Create app directory
echo "📁 Creating application directory..."
sudo mkdir -p "$APP_DIR"

# Copy files
echo "📄 Copying files..."
sudo cp -r "$TEMP_DIR"/* "$APP_DIR/"

# Set permissions
echo "🔐 Setting permissions..."
sudo chown -R www-data:www-data "$APP_DIR"
sudo chmod -R 755 "$APP_DIR"

# Restart web server
echo "🔄 Restarting web server..."
if command -v nginx >/dev/null 2>&1; then
    sudo systemctl reload nginx
    echo "✅ Nginx reloaded"
elif command -v apache2 >/dev/null 2>&1; then
    sudo systemctl reload apache2
    echo "✅ Apache2 reloaded"
fi

# Cleanup
echo "🧹 Cleaning up..."
sudo rm -rf "$TEMP_DIR"

echo "🎉 Deployment completed!"
echo "Your app should be available at: http://$(hostname -I | awk '{print $1}')/eduetor"
