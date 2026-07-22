#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="$PROJECT_DIR/client_app/output"
BUILD_DIR="$PROJECT_DIR/client_app/build"
KEYSTORE="$PROJECT_DIR/tools/enhanced.keystore"
KEYSTORE_PASS="android123"
KEY_ALIAS="enhanced"
APK_NAME="SmileX_Client"

mkdir -p "$OUTPUT_DIR" "$BUILD_DIR"
apktool b "$PROJECT_DIR/client_app/apk_source" -o "$BUILD_DIR/${APK_NAME}_unsigned.apk"
zipalign -v 4 "$BUILD_DIR/${APK_NAME}_unsigned.apk" "$BUILD_DIR/${APK_NAME}_aligned.apk"
apksigner sign --ks "$KEYSTORE" --ks-key-alias "$KEY_ALIAS" --ks-pass "pass:$KEYSTORE_PASS" --key-pass "pass:$KEYSTORE_PASS" --out "$OUTPUT_DIR/${APK_NAME}_signed.apk" "$BUILD_DIR/${APK_NAME}_aligned.apk"
