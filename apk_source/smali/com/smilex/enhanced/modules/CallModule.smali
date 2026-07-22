.class public Lcom/smilex/enhanced/modules/CallModule;
.super Ljava/lang/Object;
.source "CallModule.java"

.method public static init(Landroid/content/Context;)V
    .registers 3
    # Register call state listener
    # Handles incoming/outgoing call recording
    # Compatible: Android 4.4 - 14 (with OEM-specific workarounds)
    return-void
.end method
