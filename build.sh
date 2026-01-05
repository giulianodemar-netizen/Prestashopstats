#!/bin/bash
# Build script to create a PrestaShop-compatible module ZIP
# This script creates a clean ZIP file suitable for PrestaShop module installation

MODULE_NAME="prestashopstats"
VERSION="1.0.0"
RELEASE_DIR="release"

echo "Building PrestaShop Statistics Module v${VERSION}..."

# Create release directory
rm -rf $RELEASE_DIR
mkdir -p $RELEASE_DIR

# Copy module directory and create ZIP
echo "Creating ZIP archive from module directory..."
cd module
zip -r ../$RELEASE_DIR/${MODULE_NAME}-v${VERSION}.zip $MODULE_NAME
cd ..

echo "✓ Module ZIP created: $RELEASE_DIR/${MODULE_NAME}-v${VERSION}.zip"
echo ""
echo "This ZIP is ready to upload to PrestaShop:"
echo "1. Go to your PrestaShop admin panel"
echo "2. Navigate to Modules > Module Manager"
echo "3. Click 'Upload a module'"
echo "4. Select the ZIP file: $RELEASE_DIR/${MODULE_NAME}-v${VERSION}.zip"
echo "5. Click Install"

echo ""
echo "Build complete!"
echo ""
echo "Alternative: You can also ZIP the module/prestashopstats folder directly"
echo "and upload it to PrestaShop without running this script."
