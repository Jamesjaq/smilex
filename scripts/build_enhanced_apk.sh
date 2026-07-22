#!/bin/bash
# =============================================================================
# SmileX Enhanced APK Builder
# Builds a unified APK with all features from KidsGuard, Spyzie, and hwapp391
# Compatible with Android 4.4 (API 19) through Android 14 (API 34)
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="$PROJECT_DIR/output"
BUILD_DIR="$PROJECT_DIR/build"
KEYSTORE="$PROJECT_DIR/tools/enhanced.keystore"
KEYSTORE_PASS="android123"
KEY_ALIAS="enhanced"
APK_NAME="SmileX_Enhanced"

echo "============================================="
echo "  SmileX Enhanced APK Builder"
echo "  Cross-Compatible: Android 4.4 - Android 14"
echo "============================================="

# Check dependencies
check_deps() {
    echo "[*] Checking dependencies..."
    for cmd in apktool apksigner zipalign keytool java; do
        if ! command -v "$cmd" &>/dev/null; then
            echo "[!] Missing: $cmd"
            echo "    Install with: sudo apt-get install -y apktool apksigner zipalign default-jdk"
            exit 1
        fi
    done
    echo "[+] All dependencies found."
}

# Generate keystore if not exists
generate_keystore() {
    if [ ! -f "$KEYSTORE" ]; then
        echo "[*] Generating keystore..."
        mkdir -p "$(dirname "$KEYSTORE")"
        keytool -genkey -v -keystore "$KEYSTORE" \
            -alias "$KEY_ALIAS" \
            -keyalg RSA -keysize 2048 -validity 10000 \
            -dname "CN=SmileX, OU=Dev, O=Dev, L=City, S=State, C=US" \
            -storepass "$KEYSTORE_PASS" -keypass "$KEYSTORE_PASS" 2>&1
        echo "[+] Keystore generated at $KEYSTORE"
    else
        echo "[+] Keystore already exists."
    fi
}

# Build the APK
build_apk() {
    echo "[*] Building enhanced APK..."
    mkdir -p "$OUTPUT_DIR" "$BUILD_DIR"
    
    # Build with apktool
    apktool b "$PROJECT_DIR/apk_source" -o "$BUILD_DIR/${APK_NAME}_unsigned.apk" 2>&1
    echo "[+] APK built successfully."
    
    # Zipalign
    echo "[*] Zipaligning..."
    zipalign -v 4 "$BUILD_DIR/${APK_NAME}_unsigned.apk" "$BUILD_DIR/${APK_NAME}_aligned.apk" 2>&1
    echo "[+] Zipalign complete."
    
    # Sign
    echo "[*] Signing APK..."
    apksigner sign \
        --ks "$KEYSTORE" \
        --ks-key-alias "$KEY_ALIAS" \
        --ks-pass "pass:$KEYSTORE_PASS" \
        --key-pass "pass:$KEYSTORE_PASS" \
        --out "$OUTPUT_DIR/${APK_NAME}_signed.apk" \
        "$BUILD_DIR/${APK_NAME}_aligned.apk" 2>&1
    echo "[+] APK signed: $OUTPUT_DIR/${APK_NAME}_signed.apk"
    
    # Verify
    echo "[*] Verifying signature..."
    apksigner verify --verbose "$OUTPUT_DIR/${APK_NAME}_signed.apk" 2>&1
    echo "[+] Verification complete."
}

check_deps
generate_keystore
build_apk

echo ""
echo "============================================="
echo "[SUCCESS] Build complete!"
echo "Output: $OUTPUT_DIR/${APK_NAME}_signed.apk"
echo "============================================="
