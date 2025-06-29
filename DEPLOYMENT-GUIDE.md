# 🚀 Deployment Setup Guide

## ✅ Current Setup

Your deployment pipeline includes:
- ✅ **GitHub Actions**: Automated deployment workflow
- ✅ **Nginx Configuration**: Production-ready web server config
- ✅ **Environment Configs**: Development and production settings
- ✅ **Build Optimization**: Compressed production builds

## 🔧 Setup GitHub Secrets

In your GitHub repository, go to **Settings** → **Secrets and variables** → **Actions**:

| Secret Name | Description | Example |
|-------------|-------------|---------|
| `ORACLE_VM_HOST` | Oracle VM IP or domain | `123.45.67.89` |
| `ORACLE_VM_USER` | SSH username | `ubuntu` or `opc` |
| `ORACLE_VM_SSH_KEY` | Private SSH key content | Contents of `~/.ssh/id_rsa` |

### 📋 Getting Your SSH Key

**Generate if needed:**
```bash
ssh-keygen -t rsa -b 4096 -C "your-email@example.com"
```

**Get private key content:**
```bash
# Linux/Mac
cat ~/.ssh/id_rsa

# Windows
Get-Content $env:USERPROFILE\.ssh\id_rsa
```

**Add public key to server:**
```bash
ssh-copy-id user@your-server
# Or manually: cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

## 🎯 Deployment Process

### Automatic (Recommended)
1. Push code to `master` branch
2. GitHub Actions automatically:
   - Builds the Angular app
   - Creates deployment package
   - Uploads to Oracle VM
   - Extracts and deploys files
   - Sets proper permissions
   - Reloads web server

### Manual Alternative
```bash
# Build locally
npm run build

# Copy to server
scp -r dist/eduetor-frontend/* user@server:/tmp/

# Deploy on server
ssh user@server
sudo mkdir -p /var/www/html/eduetor
sudo cp -r /tmp/* /var/www/html/eduetor/
sudo chown -R www-data:www-data /var/www/html/eduetor
sudo systemctl reload nginx
```

## 🛠️ Server Prerequisites

Your Oracle VM needs:

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install nginx
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Create directories
sudo mkdir -p /var/www/html/eduetor
sudo mkdir -p /var/www/backups
sudo chown -R www-data:www-data /var/www/html
```

## 📝 Nginx Configuration (Optional)

Use the provided config file:
```bash
sudo cp nginx/eduetor.conf /etc/nginx/sites-available/eduetor
sudo ln -s /etc/nginx/sites-available/eduetor /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

## 🚨 Troubleshooting

### SSH Issues
- Verify key format in GitHub secrets
- Test connection: `ssh user@your-server`
- Check user sudo privileges

### Permission Issues
```bash
sudo chown -R www-data:www-data /var/www/html/eduetor
sudo chmod -R 755 /var/www/html/eduetor
```

### Build Issues
- Check GitHub Actions logs
- Verify Node.js version (18+)
- Clear cache: `npm cache clean --force`

### Website Not Loading
- Check nginx: `sudo systemctl status nginx`
- Verify files: `ls -la /var/www/html/eduetor/`
- Check logs: `sudo tail -f /var/log/nginx/error.log`

## 🔍 Verification

1. **Build Test**: `npm run build` (should complete successfully)
2. **Push Test**: Push to GitHub and check Actions tab
3. **Access Test**: Visit `http://YOUR-VM-IP/eduetor`

## 📞 Next Steps

1. ✅ Set up GitHub secrets
2. ✅ Push code to trigger deployment
3. ✅ Verify application is running
4. 🔧 Customize for your needs
5. 🌟 Start building features!

---

**Deployment pipeline ready!** 🎉 Push your code and watch it deploy automatically.
