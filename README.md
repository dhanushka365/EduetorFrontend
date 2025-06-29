# Eduetor Frontend

Angular application for the Eduetor educational platform.

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Start development server
npm start

# Build for production
npm run build
```

## 📦 Deployment

### Automatic Deployment (GitHub Actions)

1. **Set GitHub Secrets** in your repository settings:
   - `ORACLE_VM_HOST` - Your Oracle VM IP address
   - `ORACLE_VM_USER` - SSH username (e.g., `ubuntu`, `opc`)
   - `ORACLE_VM_SSH_KEY` - Your private SSH key content

2. **Standard Deployment** (push to master):
   ```bash
   git push origin master
   ```

3. **Docker Deployment** (manual trigger):
   - Go to Actions tab → "Docker Deploy to Oracle VM"
   - Click "Run workflow" → Select "docker"

4. **Access your app** at: `http://YOUR-VM-IP/eduetor` (standard) or `http://YOUR-VM-IP` (docker)

### Docker Deployment (Local)

```bash
# Build and run with Docker Compose
docker-compose up -d

# Or build and run manually
docker build -t eduetor-frontend .
docker run -d -p 80:80 --name eduetor-frontend eduetor-frontend
```

### Manual Deployment

```bash
# Build the app
npm run build

# Copy files to server
scp -r dist/eduetor-frontend/* user@your-server:/tmp/

# SSH into server and deploy
ssh user@your-server
sudo mkdir -p /var/www/html/eduetor
sudo cp -r /tmp/* /var/www/html/eduetor/
sudo chown -R www-data:www-data /var/www/html/eduetor
sudo systemctl reload nginx
```

## 🔧 Server Setup

Ensure your Oracle VM has nginx installed:

```bash
sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
```

## 🔍 Development

- **Dev Server**: `http://localhost:4200`
- **Build Output**: `dist/eduetor-frontend/`
- **Environment Config**: `src/environments/`

## 📁 Project Structure

```
src/
├── app/                 # Main application
├── assets/             # Static assets
├── environments/       # Environment configs
└── index.html         # Main HTML file
```

## 🛠️ Scripts

- `npm start` - Development server
- `npm run build` - Production build
- `npm test` - Run tests
- `npm run test:ci` - CI tests

---

For detailed deployment setup, see `DEPLOYMENT-GUIDE.md`
