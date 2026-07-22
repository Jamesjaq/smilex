#!/bin/bash
# =============================================================================
# SmileX APK Decompiler & Analyzer
# Decompiles all APKs in the repo and generates a feature analysis report
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
DECOMPILE_DIR="$PROJECT_DIR/decompiled"
REPORT_DIR="$PROJECT_DIR/reports"

echo "============================================="
echo "  SmileX APK Decompiler & Analyzer"
echo "============================================="

mkdir -p "$DECOMPILE_DIR" "$REPORT_DIR"

# Decompile all APKs found in the project
decompile_all() {
    echo "[*] Searching for APK files..."
    find "$PROJECT_DIR" -maxdepth 2 -name "*.apk" | while read apk; do
        apk_name=$(basename "$apk" .apk | tr ' ' '_' | tr '[:upper:]' '[:lower:]')
        out_dir="$DECOMPILE_DIR/$apk_name"
        echo "[*] Decompiling: $apk -> $out_dir"
        apktool d "$apk" -o "$out_dir" -f 2>&1 | tail -3
        echo "[+] Done: $apk_name"
    done
}

# Analyze permissions across all decompiled APKs
analyze_permissions() {
    echo ""
    echo "[*] Analyzing permissions..."
    REPORT="$REPORT_DIR/permissions_analysis.txt"
    echo "SmileX Permission Analysis Report" > "$REPORT"
    echo "Generated: $(date)" >> "$REPORT"
    echo "==========================================" >> "$REPORT"
    
    find "$DECOMPILE_DIR" -name "AndroidManifest.xml" | while read manifest; do
        apk_dir=$(dirname "$manifest")
        apk_name=$(basename "$apk_dir")
        echo "" >> "$REPORT"
        echo "=== $apk_name ===" >> "$REPORT"
        grep 'uses-permission' "$manifest" | \
            sed 's/.*android:name="//;s/".*//' | sort >> "$REPORT"
    done
    echo "[+] Permission report saved to $REPORT"
}

# Extract all unique permissions (union)
extract_union_permissions() {
    echo ""
    echo "[*] Computing permission union..."
    UNION="$REPORT_DIR/union_permissions.txt"
    find "$DECOMPILE_DIR" -name "AndroidManifest.xml" \
        -exec grep 'uses-permission' {} \; | \
        sed 's/.*android:name="//;s/".*//' | \
        sort -u > "$UNION"
    echo "[+] Union permissions saved to $UNION"
    echo "    Total unique permissions: $(wc -l < "$UNION")"
}

# Analyze services, receivers, activities
analyze_components() {
    echo ""
    echo "[*] Analyzing app components..."
    COMP_REPORT="$REPORT_DIR/components_analysis.txt"
    echo "SmileX Components Analysis Report" > "$COMP_REPORT"
    echo "Generated: $(date)" >> "$COMP_REPORT"
    echo "==========================================" >> "$COMP_REPORT"
    
    find "$DECOMPILE_DIR" -name "AndroidManifest.xml" | while read manifest; do
        apk_name=$(basename "$(dirname "$manifest")")
        echo "" >> "$COMP_REPORT"
        echo "=== $apk_name ===" >> "$COMP_REPORT"
        echo "--- Activities ---" >> "$COMP_REPORT"
        grep -o 'android:name="[^"]*"' "$manifest" | grep -i "activity" | head -10 >> "$COMP_REPORT" || true
        echo "--- Services ---" >> "$COMP_REPORT"
        grep '<service' "$manifest" | grep -o 'android:name="[^"]*"' >> "$COMP_REPORT" || true
        echo "--- Receivers ---" >> "$COMP_REPORT"
        grep '<receiver' "$manifest" | grep -o 'android:name="[^"]*"' >> "$COMP_REPORT" || true
    done
    echo "[+] Components report saved to $COMP_REPORT"
}

decompile_all
analyze_permissions
extract_union_permissions
analyze_components

echo ""
echo "============================================="
echo "[SUCCESS] Analysis complete! Reports in $REPORT_DIR"
echo "============================================="
