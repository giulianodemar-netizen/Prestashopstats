# Quick ZIP Creation Guide

## Problem
PrestaShop shows "Oops, something went wrong" when uploading the module ZIP.

## Solution
The ZIP structure must be correct. With the new repository structure, it's now much easier!

---

## Method 1: Use Build Script (Easiest) ⭐

```bash
./build.sh
```

Upload the file: `release/prestashopstats-v1.0.0.zip`

---

## Method 2: ZIP the Module Folder Directly (Simple) ⭐⭐

```bash
cd module
zip -r prestashopstats.zip prestashopstats/
# Upload prestashopstats.zip to PrestaShop
```

Or on Windows:
1. Navigate to the `module` folder
2. Right-click on the `prestashopstats` folder
3. Select "Send to" > "Compressed (zipped) folder"
4. Upload the ZIP to PrestaShop

---

## Method 3: Manual ZIP Creation (If needed)

### Linux/Mac
```bash
cd module
zip -r ../prestashopstats.zip prestashopstats/
```

### Windows
1. Open the `module` folder
2. Select the `prestashopstats` folder
3. Right-click > "Send to" > "Compressed (zipped) folder"
4. Move the ZIP to your desktop or desired location

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

## New Repository Structure (Easy!)

With the new organization, all module files are already in the `module/prestashopstats/` folder:

```
Prestashopstats/                    # Repository root
├── module/                         # Module directory
│   └── prestashopstats/           # ← ZIP THIS FOLDER!
│       ├── prestashopstats.php
│       ├── config.xml
│       ├── controllers/
│       ├── views/
│       └── translations/
├── README.md                       # Documentation (not in module)
├── INSTALLATION.md                 # Documentation (not in module)
└── build.sh                        # Build script
```

**Simply ZIP the `module/prestashopstats` folder and you're done!**

---

## What NOT to Include ❌

The new structure already separates module files from documentation:
- ❌ Don't ZIP the entire repository root
- ❌ Don't include the `docs/` folder
- ❌ Don't include README.md, CHANGELOG.md, etc.
- ✅ Only ZIP the `module/prestashopstats` folder

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

## After Creating ZIP

1. Go to PrestaShop admin
2. Modules → Module Manager
3. Click "Upload a module"
4. Select your prestashopstats.zip
5. Click upload and wait
6. Module should install successfully!

---

For detailed instructions, see [INSTALLATION.md](INSTALLATION.md)
