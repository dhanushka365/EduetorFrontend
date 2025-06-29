# 🚀 Quick Deployment Setup Guide

## ✅ Issues Fixed

The deployment pipeline has been fixed and now includes:

1. **✅ Package Lock File**: `package-lock.json` generated for npm caching
2. **✅ Version Compatibility**: Angular 17.3 versions aligned
3. **✅ Build Verification**: Successfully builds locally  
4. **✅ Test Configuration**: Karma config and basic tests added
5. **✅ Robust Workflows**: Two deployment options available

## 🔧 Setup Your GitHub Secrets

In your GitHub repository, go to **Settings** → **Secrets and variables** → **Actions**, then add:

| Secret Name | Description | Example |
|-------------|-------------|---------|
| `ORACLE_VM_HOST` | Your Oracle VM IP or domain | `123.45.67.89` |
| `ORACLE_VM_USER` | SSH username for your VM | `ubuntu` or `opc` |
| `ORACLE_VM_SSH_KEY` | Your private SSH key content | Contents of your `~/.ssh/id_rsa` file |

### 📋 How to get your SSH key:

**On Windows:**
```powershell
# Generate key if you don't have one
ssh-keygen -t rsa -b 4096 -C "your-email@example.com"

# Display private key content
Get-Content $env:USERPROFILE\.ssh\id_rsa
```

**On Linux/Mac:**
```bash
# Generate key if you don't have one  
ssh-keygen -t rsa -b 4096 -C "your-email@example.com"

# Display private key content
cat ~/.ssh/id_rsa
```

## 🎯 Deployment Options

### Option 1: Automatic Deployment (Recommended)
- **File**: `.github/workflows/deploy.yml`
- **Trigger**: Push to master/main branch
- **Features**: Full testing, backup, verification

### Option 2: Simple Deployment (Fallback)
- **File**: `.github/workflows/simple-deploy.yml` 
- **Trigger**: Manual or push
- **Features**: Basic deployment without complex testing

### Option 3: Manual Deployment
```bash
# Build locally
npm run build

# Copy to server
scp -r dist/eduetor-frontend/* user@your-server:/tmp/

# SSH and deploy
ssh user@your-server
sudo mkdir -p /var/www/html/eduetor
sudo cp -r /tmp/* /var/www/html/eduetor/
sudo chown -R www-data:www-data /var/www/html/eduetor
```

## 🔍 Testing Your Setup

1. **Local Build Test**:
   ```bash
   npm run build
   # Should complete without errors
   ```

2. **Push to GitHub**:
   ```bash
   git push origin master
   # Check Actions tab for deployment progress
   ```

3. **Verify Deployment**:
   - Visit: `http://YOUR-ORACLE-VM-IP/eduetor`
   - Should show "Welcome to Eduetor Frontend!"

## 🛠️ Server Prerequisites

Make sure your Oracle VM has:

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install nginx
sudo apt install nginx -y

# Start and enable nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Create web directories
sudo mkdir -p /var/www/html/eduetor
sudo mkdir -p /var/www/backups

# Set permissions
sudo chown -R www-data:www-data /var/www/html
```

## 🚨 Troubleshooting

### Common Issues:

1. **SSH Connection Failed**
   - Verify SSH key is correctly formatted in GitHub secrets
   - Test SSH connection manually: `ssh user@your-server`

2. **Permission Denied**
   - Ensure user has sudo privileges
   - Check directory permissions: `ls -la /var/www/`

3. **Build Failed**
   - Check GitHub Actions logs
   - Verify all dependencies in package.json

4. **Website Not Loading**
   - Check nginx status: `sudo systemctl status nginx`
   - Verify files exist: `ls -la /var/www/html/eduetor/`

## 📞 Next Steps

1. ✅ Set up GitHub secrets
2. ✅ Push code to trigger deployment  
3. ✅ Verify application is running
4. 🔧 Configure nginx (optional, using provided config)
5. 🌟 Start building your Eduetor features!

---

**Your deployment pipeline is now ready!** 🎉

Push your code changes and watch the magic happen in the GitHub Actions tab.
