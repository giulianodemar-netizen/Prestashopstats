# Quick ZIP Creation Guide

## Problem
PrestaShop shows "Oops, something went wrong" when uploading the module ZIP.

## Solution
The ZIP structure must be correct. Use one of these methods:

---

## Method 1: Use Build Script (Easiest) ⭐

```bash
./build.sh
```

Upload the file: `release/prestashopstats-v1.0.0.zip`

---

## Method 2: Manual ZIP Creation (Linux/Mac)

```bash
# From repository root
mkdir -p /tmp/ps-module/prestashopstats

# Copy only module files (NO documentation)
cp prestashopstats.php /tmp/ps-module/prestashopstats/
cp config.xml /tmp/ps-module/prestashopstats/
cp index.php /tmp/ps-module/prestashopstats/
cp LICENSE /tmp/ps-module/prestashopstats/
cp -r controllers /tmp/ps-module/prestashopstats/
cp -r views /tmp/ps-module/prestashopstats/
cp -r translations /tmp/ps-module/prestashopstats/

# Create ZIP
cd /tmp/ps-module
zip -r prestashopstats.zip prestashopstats/

# Your ZIP is ready!
# Upload /tmp/ps-module/prestashopstats.zip to PrestaShop
```

---

## Method 3: Manual ZIP Creation (Windows)

1. Create a folder named `prestashopstats`

2. Copy ONLY these files into it:
   - prestashopstats.php
   - config.xml
   - index.php
   - LICENSE
   - controllers/ (entire folder)
   - views/ (entire folder)
   - translations/ (entire folder)

3. Select the `prestashopstats` folder (not the files inside)

4. Right-click → "Send to" → "Compressed (zipped) folder"

5. Rename to `prestashopstats.zip`

---

## Correct ZIP Structure

```
prestashopstats.zip
  └── prestashopstats/              ← Folder name must be exact
      ├── prestashopstats.php       ← Main module file
      ├── config.xml
      ├── index.php
      ├── LICENSE
      ├── controllers/
      │   └── admin/
      │       └── AdminPrestaShopStatsController.php
      ├── views/
      │   ├── css/
      │   ├── js/
      │   └── templates/
      └── translations/
          └── en.php
```

---

## What NOT to Include ❌

Do NOT include these in your ZIP:
- ❌ README.md
- ❌ DOCUMENTATION.md
- ❌ INSTALLATION.md
- ❌ CHANGELOG.md
- ❌ FAQ.md
- ❌ CONTRIBUTING.md
- ❌ composer.json
- ❌ screenshots/ folder
- ❌ docs/ folder
- ❌ build/ folder
- ❌ .git/ folder
- ❌ .gitignore

---

## Verify Your ZIP

```bash
# Check structure (Linux/Mac)
unzip -l prestashopstats.zip | head -20

# Should see:
# prestashopstats/
# prestashopstats/prestashopstats.php
# prestashopstats/config.xml
# etc.
```

---

## Still Having Issues?

1. **Check ZIP size**: Should be < 5MB (without documentation)
2. **Check folder name**: Must be lowercase `prestashopstats`
3. **Check PHP settings**: upload_max_filesize in php.ini
4. **Check PrestaShop logs**: var/logs/ directory
5. **Enable debug mode**: config/defines.inc.php → _PS_MODE_DEV_ = true

---

## After Creating ZIP

1. Go to PrestaShop admin
2. Modules → Module Manager
3. Click "Upload a module"
4. Select your prestashopstats.zip
5. Click upload and wait
6. Module should install successfully!

---

For detailed instructions, see [INSTALLATION.md](INSTALLATION.md)
