#!/bin/bash
# Build script to create a PrestaShop-compatible module ZIP
# This script creates a clean ZIP file suitable for PrestaShop module installation

MODULE_NAME="prestashopstats"
VERSION="1.0.0"
BUILD_DIR="build"
RELEASE_DIR="release"

echo "Building PrestaShop Statistics Module v${VERSION}..."

# Create build and release directories
rm -rf $BUILD_DIR $RELEASE_DIR
mkdir -p $BUILD_DIR/$MODULE_NAME
mkdir -p $RELEASE_DIR

# Copy only necessary module files (exclude documentation and development files)
echo "Copying module files..."

# Core files
cp prestashopstats.php $BUILD_DIR/$MODULE_NAME/
cp config.xml $BUILD_DIR/$MODULE_NAME/
cp index.php $BUILD_DIR/$MODULE_NAME/
cp LICENSE $BUILD_DIR/$MODULE_NAME/

# Copy directories
cp -r controllers $BUILD_DIR/$MODULE_NAME/
cp -r views $BUILD_DIR/$MODULE_NAME/
cp -r translations $BUILD_DIR/$MODULE_NAME/

# Optional: Include composer.json if needed (commented out by default)
# cp composer.json $BUILD_DIR/$MODULE_NAME/

echo "Creating ZIP archive..."
cd $BUILD_DIR
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

# Cleanup
rm -rf $BUILD_DIR

echo ""
echo "Build complete!"
