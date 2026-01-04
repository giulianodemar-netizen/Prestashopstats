# PrestaShop Statistics Module - Installation Guide

This guide will walk you through the installation and setup process for the PrestaShop Statistics Module.

## Prerequisites

Before installing the module, ensure your PrestaShop installation meets the following requirements:

- PrestaShop version 1.7.8.0 or higher (compatible with 8.x and 9.x)
- PHP 7.1 or higher
- MySQL 5.6 or higher
- Write permissions on the modules directory

## Installation Methods

### Method 1: ZIP Upload (Recommended)

**IMPORTANT:** PrestaShop requires a specific ZIP structure. Do not simply ZIP the repository root!

#### Option A: Use the Build Script (Easiest)

1. **Run the build script** (Linux/Mac)
   ```bash
   cd /path/to/Prestashopstats
   ./build.sh
   ```
   
   This creates a properly structured ZIP at `release/prestashopstats-v1.0.0.zip`

2. **Upload via Admin Panel**
   - Log in to your PrestaShop admin panel
   - Go to **Modules** > **Module Manager**
   - Click **Upload a module** button
   - Select `release/prestashopstats-v1.0.0.zip`
   - Click **Upload**
   - The module will be automatically installed

#### Option B: Manual ZIP Creation

1. **Create proper ZIP structure**
   
   The ZIP must contain a folder named `prestashopstats` with module files inside:
   
   ```
   prestashopstats.zip
     └── prestashopstats/
         ├── prestashopstats.php
         ├── config.xml
         ├── index.php
         ├── LICENSE
         ├── controllers/
         ├── views/
         └── translations/
   ```
   
   **DO NOT include these files in the ZIP:**
   - README.md, DOCUMENTATION.md, and other markdown files
   - composer.json (unless needed)
   - screenshots/, docs/, build/, release/ folders
   - .git/, .gitignore

2. **Create ZIP manually** (Linux/Mac)
   ```bash
   # From the repository root
   mkdir -p /tmp/prestashopstats-build/prestashopstats
   
   # Copy only module files
   cp prestashopstats.php /tmp/prestashopstats-build/prestashopstats/
   cp config.xml /tmp/prestashopstats-build/prestashopstats/
   cp index.php /tmp/prestashopstats-build/prestashopstats/
   cp LICENSE /tmp/prestashopstats-build/prestashopstats/
   cp -r controllers /tmp/prestashopstats-build/prestashopstats/
   cp -r views /tmp/prestashopstats-build/prestashopstats/
   cp -r translations /tmp/prestashopstats-build/prestashopstats/
   
   # Create ZIP
   cd /tmp/prestashopstats-build
   zip -r prestashopstats.zip prestashopstats/
   ```

3. **Upload via Admin Panel**
   - Log in to your PrestaShop admin panel
   - Go to **Modules** > **Module Manager**
   - Click **Upload a module** button
   - Select the `prestashopstats.zip` file
   - Click **Upload**
   - The module will be automatically installed

### Method 2: Direct FTP Upload

1. **Prepare module files**
   - Use the build script or manually copy only the necessary module files (as shown in Method 1)
   - Do NOT upload documentation files like README.md, CHANGELOG.md, etc.

2. **Upload to PrestaShop**
   ```bash
   # Via FTP/SFTP
   - Connect to your server
   - Navigate to /modules/ directory
   - Create a folder named 'prestashopstats'
   - Upload ONLY these files/folders to /modules/prestashopstats/:
     * prestashopstats.php
     * config.xml
     * index.php
     * LICENSE
     * controllers/
     * views/
     * translations/
   ```

3. **Set Permissions**
   ```bash
   # Via SSH (optional but recommended)
   cd /path/to/prestashop/modules/prestashopstats
   find . -type f -exec chmod 644 {} \;
   find . -type d -exec chmod 755 {} \;
   ```

4. **Install via Admin Panel**
   - Log in to your PrestaShop admin panel
   - Go to **Modules** > **Module Manager**
   - Search for "PrestaShop Statistics" or "prestashopstats"
   - Click the **Install** button
   - Wait for the installation to complete

### Method 3: Command Line (Advanced)

If you have SSH access:

```bash
# Navigate to PrestaShop modules directory
cd /path/to/prestashop/modules

# Clone or copy the module
git clone https://github.com/giulianodemar-netizen/Prestashopstats.git prestashopstats
# OR
cp -r /path/to/prestashopstats .

# Set proper permissions
chmod -R 755 prestashopstats

# Install via CLI (PrestaShop 1.7+)
cd /path/to/prestashop
php bin/console prestashop:module install prestashopstats
```

## Post-Installation Setup

### 1. Verify Installation

After installation, verify that the module is active:

1. Go to **Modules** > **Module Manager**
2. Search for "PrestaShop Statistics"
3. Status should show as "Enabled"

### 2. Check Database Tables

The module creates three tables automatically. Verify they exist:

```sql
-- Connect to your PrestaShop database
SELECT TABLE_NAME 
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'your_database_name' 
AND TABLE_NAME LIKE 'ps_prestashopstats_%';

-- Expected results:
-- ps_prestashopstats_page_views
-- ps_prestashopstats_traffic
-- ps_prestashopstats_conversions
```

Replace `ps_` with your actual database prefix if different.

### 3. Access the Dashboard

1. Log in to PrestaShop admin panel
2. Navigate to **Stats** menu in the left sidebar
3. Click on **Statistics Dashboard**
4. You should see the statistics dashboard

### 4. Configure Settings (Optional)

1. Go to **Modules** > **Module Manager**
2. Search for "PrestaShop Statistics"
3. Click **Configure**
4. Adjust settings:
   - **Enable Tracking**: Turn on/off visitor tracking

## Verification Checklist

After installation, verify the following:

- [ ] Module appears in Module Manager
- [ ] Module status is "Enabled"
- [ ] "Statistics Dashboard" menu item appears under Stats
- [ ] Dashboard loads without errors
- [ ] Sales statistics display correctly
- [ ] Customer insights show data
- [ ] Date range filter works
- [ ] No PHP errors in error logs

## Troubleshooting

### "Oops, something went wrong" Error During ZIP Upload

**Problem**: When uploading the module ZIP, PrestaShop shows "ops qualcosa è andato storto" (oops something went wrong)

**Root Cause**: The ZIP file structure is incorrect or contains files that PrestaShop doesn't expect.

**Solutions**:

1. **Use the Build Script (Recommended)**
   ```bash
   cd /path/to/Prestashopstats
   ./build.sh
   ```
   This creates a properly structured ZIP at `release/prestashopstats-v1.0.0.zip`

2. **Check ZIP Structure**
   The ZIP must have this exact structure:
   ```
   prestashopstats.zip
     └── prestashopstats/          ← Folder must be named 'prestashopstats'
         ├── prestashopstats.php   ← Main module file
         ├── config.xml
         ├── index.php
         ├── LICENSE
         ├── controllers/
         ├── views/
         └── translations/
   ```
   
   **Common Mistakes:**
   - ❌ Documentation files (README.md, CHANGELOG.md, etc.) at module root
   - ❌ Extra folders (docs/, screenshots/, build/, .git/)
   - ❌ Files directly in ZIP root without prestashopstats/ folder
   - ❌ Wrong folder name (Prestashopstats instead of prestashopstats)

3. **Verify ZIP Contents**
   ```bash
   unzip -l yourfile.zip | head -20
   ```
   First line should show: `prestashopstats/`

4. **Create Clean ZIP Manually**
   ```bash
   # From repository root
   mkdir -p /tmp/ps-build/prestashopstats
   cp prestashopstats.php config.xml index.php LICENSE /tmp/ps-build/prestashopstats/
   cp -r controllers views translations /tmp/ps-build/prestashopstats/
   cd /tmp/ps-build
   zip -r prestashopstats.zip prestashopstats/
   ```

5. **Check PrestaShop Logs**
   ```bash
   # Check for specific error messages
   tail -f /path/to/prestashop/var/logs/*.log
   ```

6. **Verify File Size**
   - If ZIP is too large (>50MB), it may exceed PHP upload limits
   - Check `upload_max_filesize` and `post_max_size` in php.ini

### Installation Fails

**Problem**: Module installation fails with an error

**Solutions**:
1. Check file permissions:
   ```bash
   chmod -R 755 /path/to/prestashop/modules/prestashopstats
   ```

2. Check PHP error logs:
   ```bash
   tail -f /var/log/php_errors.log
   ```

3. Enable PrestaShop debug mode:
   - Edit `/config/defines.inc.php`
   - Set `define('_PS_MODE_DEV_', true);`
   - Try installing again and check for detailed errors

4. Verify database permissions:
   - Ensure PrestaShop database user has CREATE TABLE privileges

### Database Tables Not Created

**Problem**: Module installs but tables are missing

**Solutions**:
1. Manually create tables by executing SQL:
   ```sql
   -- See the SQL in prestashopstats.php createTables() method
   -- Execute each CREATE TABLE statement manually
   ```

2. Uninstall and reinstall the module:
   - Go to Module Manager
   - Uninstall the module
   - Clear cache
   - Install again

### Menu Item Not Appearing

**Problem**: "Statistics Dashboard" doesn't appear in Stats menu

**Solutions**:
1. Clear PrestaShop cache:
   ```bash
   rm -rf /path/to/prestashop/var/cache/*
   ```

2. Regenerate admin menu:
   - Go to **Advanced Parameters** > **Performance**
   - Click **Clear cache**

3. Check tab installation:
   ```sql
   SELECT * FROM ps_tab WHERE class_name = 'AdminPrestaShopStats';
   ```
   If no results, reinstall the module.

### No Data Displayed

**Problem**: Dashboard loads but shows no data

**Solutions**:
1. Verify you have orders in the date range
2. Check if orders are valid (not in cart status)
3. Adjust date range to include known orders
4. Check database for orders:
   ```sql
   SELECT COUNT(*) FROM ps_orders WHERE valid = 1;
   ```

### Permission Denied Errors

**Problem**: File permission errors

**Solutions**:
```bash
# Set proper ownership
chown -R www-data:www-data /path/to/prestashop/modules/prestashopstats

# Set proper permissions
find /path/to/prestashop/modules/prestashopstats -type f -exec chmod 644 {} \;
find /path/to/prestashop/modules/prestashopstats -type d -exec chmod 755 {} \;
```

## Uninstallation

If you need to uninstall the module:

### Via Admin Panel

1. Go to **Modules** > **Module Manager**
2. Search for "PrestaShop Statistics"
3. Click **Uninstall**
4. Confirm the uninstallation

**Note**: Uninstalling will remove all custom database tables and tracked data.

### Manual Uninstallation

If admin uninstall fails:

```bash
# Remove module files
rm -rf /path/to/prestashop/modules/prestashopstats

# Remove database tables (connect to MySQL first)
DROP TABLE IF EXISTS ps_prestashopstats_page_views;
DROP TABLE IF EXISTS ps_prestashopstats_traffic;
DROP TABLE IF EXISTS ps_prestashopstats_conversions;

# Remove module from database
DELETE FROM ps_module WHERE name = 'prestashopstats';
DELETE FROM ps_tab WHERE class_name = 'AdminPrestaShopStats';

# Clear cache
rm -rf /path/to/prestashop/var/cache/*
```

## Upgrade Process

When a new version is available:

1. **Backup First**:
   ```bash
   # Backup module files
   cp -r /path/to/prestashop/modules/prestashopstats /path/to/backup/
   
   # Backup database
   mysqldump -u user -p database_name > backup.sql
   ```

2. **Upload New Version**:
   - Download the new version
   - Replace files in `/modules/prestashopstats/`

3. **Run Upgrade**:
   - Go to Module Manager
   - Click **Upgrade** if available
   - Or uninstall and reinstall (will lose tracking data)

## Support

If you encounter issues during installation:

1. Check the DOCUMENTATION.md file
2. Review PrestaShop error logs
3. Contact support with:
   - PrestaShop version
   - PHP version
   - Error messages
   - Steps to reproduce

## Next Steps

After successful installation:

1. Read the [DOCUMENTATION.md](DOCUMENTATION.md) for usage instructions
2. Explore the statistics dashboard
3. Set up tracking for advanced features (optional)
4. Configure date ranges for reporting
5. Share feedback or feature requests

---

**Congratulations!** Your PrestaShop Statistics Module is now installed and ready to use.
