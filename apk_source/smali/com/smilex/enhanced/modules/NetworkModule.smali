.class public Lcom/smilex/enhanced/modules/NetworkModule;
.super Ljava/lang/Object;
.source "NetworkModule.java"

.method public static init(Landroid/content/Context;)V
    .registers 3
    return-void
.end method

.method public static flushPendingUploads(Landroid/content/Context;)V
    .registers 3
    # Upload queued data to C2 server when network is available
    return-void
.end method
