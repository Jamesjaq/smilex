#!/bin/bash
APKTOOL_JAR="/home/ubuntu/apktool.jar"
SOURCE_DIR="apk_source"
BUILD_DIR="build"
OUTPUT_DIR="output"
FINAL_APK="output/SmileX_Enhanced_signed_2026_LiveStream_v2.apk"

mkdir -p $BUILD_DIR $OUTPUT_DIR

echo "[*] Building APK with apktool..."
java -jar $APKTOOL_JAR b $SOURCE_DIR -o $BUILD_DIR/SmileX_Enhanced_unsigned.apk

echo "[*] Checking for zipalign..."
if command -v zipalign &> /dev/null; then
    zipalign -v 4 $BUILD_DIR/SmileX_Enhanced_unsigned.apk $BUILD_DIR/SmileX_Enhanced_aligned.apk
else
    echo "[!] zipalign not found, skipping alignment (not recommended for production)"
    cp $BUILD_DIR/SmileX_Enhanced_unsigned.apk $BUILD_DIR/SmileX_Enhanced_aligned.apk
fi

echo "[*] Checking for apksigner..."
if command -v apksigner &> /dev/null; then
    # Using existing keystore if it exists, or creating a temporary one
    KEYSTORE="/home/ubuntu/smilex/tools/enhanced.keystore"
    if [ ! -f "$KEYSTORE" ]; then
        echo "[*] Creating temporary keystore..."
        mkdir -p tools
        keytool -genkey -v -keystore $KEYSTORE -alias enhanced -keyalg RSA -keysize 2048 -validity 10000 -storepass android123 -keypass android123 -dname "CN=SmileX, OU=Enhanced, O=SmileX, L=Global, S=Global, C=US"
    fi
    apksigner sign --ks $KEYSTORE --ks-key-alias enhanced --ks-pass pass:android123 --key-pass pass:android123 --out $FINAL_APK $BUILD_DIR/SmileX_Enhanced_aligned.apk
    echo "[*] Signed APK: $FINAL_APK"
else
    echo "[!] apksigner not found, APK is unsigned."
    cp $BUILD_DIR/SmileX_Enhanced_aligned.apk $FINAL_APK
fi
