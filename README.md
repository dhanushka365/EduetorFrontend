# Eduetor Frontend

Angular application for the Eduetor educational platform.

## 🚀 Deployment Pipeline

This project includes automated deployment to Oracle VM using GitHub Actions.

### Prerequisites

1. **Oracle VM Setup**
   - Ubuntu/CentOS server with SSH access
   - Nginx or Apache web server installed
   - Node.js 18+ (for building if needed)

2. **GitHub Repository Secrets**
   Set these secrets in your GitHub repository:
   - `ORACLE_VM_HOST`: Your Oracle VM IP address or domain
   - `ORACLE_VM_USER`: SSH username for the VM
   - `ORACLE_VM_SSH_KEY`: Private SSH key for authentication

### Deployment Methods

#### Method 1: Automatic Deployment (GitHub Actions)

1. Push code to `master` or `main` branch
2. GitHub Actions will automatically:
   - Install dependencies
   - Run tests
   - Build the application
   - Deploy to Oracle VM
   - Restart web server

#### Method 2: Manual Deployment

```bash
# Build the application locally
npm run build

# Copy files to server
scp -r dist/eduetor-frontend/* user@your-server:/tmp/eduetor-deployment/

# SSH into server and run deployment script
ssh user@your-server
chmod +x /path/to/deploy.sh
sudo ./deploy.sh
```

#### Method 3: Docker Deployment

```bash
# Build Docker image
docker build -t eduetor-frontend .

# Run with Docker Compose
docker-compose up -d

# Or run directly
docker run -d -p 80:80 --name eduetor-frontend eduetor-frontend
```

### Server Setup

#### Nginx Configuration

1. Copy the nginx configuration:
```bash
sudo cp nginx/eduetor.conf /etc/nginx/sites-available/eduetor
sudo ln -s /etc/nginx/sites-available/eduetor /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

#### Apache Configuration

For Apache users, create a virtual host:
```apache
<VirtualHost *:80>
    ServerName your-domain.com
    DocumentRoot /var/www/html/eduetor
    
    <Directory /var/www/html/eduetor>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
        
        # Handle Angular routing
        RewriteEngine On
        RewriteBase /
        RewriteRule ^index\.html$ - [L]
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule . /index.html [L]
    </Directory>
</VirtualHost>
```

### Environment Configuration

Update the following files based on your environment:

1. **API URL**: Update `src/environments/environment.prod.ts` with your backend API URL
2. **Domain**: Update `nginx/eduetor.conf` with your actual domain name
3. **Ports**: Adjust port configurations in `docker-compose.yml` if needed

### Monitoring and Logs

- **Application Logs**: Check `/var/log/nginx/` for web server logs
- **Deployment Logs**: Available in GitHub Actions workflow runs
- **Health Check**: Access `/health` endpoint to verify application status

### Troubleshooting

#### Common Issues

1. **Permission Denied**
   ```bash
   sudo chown -R www-data:www-data /var/www/html/eduetor
   sudo chmod -R 755 /var/www/html/eduetor
   ```

2. **SSH Key Issues**
   - Ensure SSH key is properly formatted in GitHub secrets
   - Check SSH key permissions on the server
   - Verify the user has sudo privileges

3. **Build Failures**
   - Check Node.js version compatibility
   - Clear npm cache: `npm cache clean --force`
   - Delete node_modules and reinstall: `rm -rf node_modules && npm install`

4. **Routing Issues**
   - Ensure web server is configured for Angular routing
   - Check that all routes fall back to `index.html`

### Security Considerations

- Keep dependencies updated
- Use HTTPS in production
- Configure proper CORS settings
- Implement rate limiting
- Regular security audits: `npm audit`

### Performance Optimization

- Enable gzip compression (included in nginx config)
- Use CDN for static assets
- Implement caching strategies
- Monitor bundle sizes: `npm run build -- --stats-json`

## 📞 Support

For deployment issues, check:
1. GitHub Actions logs
2. Server logs (`/var/log/nginx/error.log`)
3. Application console errors

---

*Last updated: $(date)*
