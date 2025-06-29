#!/bin/bash

# Deployment script for Eduetor Frontend
# This script handles the deployment process on the Oracle VM

set -e  # Exit on any error

echo "🚀 Starting Eduetor Frontend Deployment..."

# Configuration
APP_NAME="eduetor"
WEB_ROOT="/var/www/html"
APP_DIR="$WEB_ROOT/$APP_NAME"
BACKUP_DIR="/var/www/backups"
TEMP_DIR="/tmp/$APP_NAME-deployment"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to create backup
create_backup() {
    if [ -d "$APP_DIR" ]; then
        local backup_name="$APP_NAME-$(date +%Y%m%d-%H%M%S)"
        log_info "Creating backup: $backup_name"
        sudo mkdir -p "$BACKUP_DIR"
        sudo cp -r "$APP_DIR" "$BACKUP_DIR/$backup_name"
        log_info "Backup created successfully"
    else
        log_warn "No existing deployment found to backup"
    fi
}

# Function to deploy files
deploy_files() {
    log_info "Deploying files to $APP_DIR"
    
    # Create app directory
    sudo mkdir -p "$APP_DIR"
    
    # Copy files from temp directory
    if [ -d "$TEMP_DIR" ]; then
        sudo cp -r "$TEMP_DIR"/* "$APP_DIR/"
        log_info "Files copied successfully"
    else
        log_error "Deployment files not found in $TEMP_DIR"
        exit 1
    fi
}

# Function to set permissions
set_permissions() {
    log_info "Setting proper permissions"
    sudo chown -R www-data:www-data "$APP_DIR"
    sudo chmod -R 755 "$APP_DIR"
    log_info "Permissions set successfully"
}

# Function to cleanup temp files
cleanup() {
    log_info "Cleaning up temporary files"
    sudo rm -rf "$TEMP_DIR"
    log_info "Cleanup completed"
}

# Function to restart web server
restart_webserver() {
    log_info "Restarting web server"
    
    if systemctl is-active --quiet nginx; then
        sudo systemctl reload nginx
        log_info "Nginx reloaded successfully"
    elif systemctl is-active --quiet apache2; then
        sudo systemctl reload apache2
        log_info "Apache2 reloaded successfully"
    elif systemctl is-active --quiet httpd; then
        sudo systemctl reload httpd
        log_info "HTTP reloaded successfully"
    else
        log_warn "No known web server found running"
    fi
}

# Function to verify deployment
verify_deployment() {
    log_info "Verifying deployment"
    
    if [ -f "$APP_DIR/index.html" ]; then
        log_info "✅ Deployment verification successful"
        log_info "Application is available at: http://$(hostname -I | awk '{print $1}')/$APP_NAME"
    else
        log_error "❌ Deployment verification failed - index.html not found"
        exit 1
    fi
}

# Main deployment process
main() {
    log_info "Starting deployment process..."
    
    create_backup
    deploy_files
    set_permissions
    restart_webserver
    cleanup
    verify_deployment
    
    log_info "🎉 Deployment completed successfully!"
}

# Run main function
main "$@"
