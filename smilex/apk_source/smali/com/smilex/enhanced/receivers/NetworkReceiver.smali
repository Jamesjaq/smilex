.class public Lcom/smilex/enhanced/receivers/NetworkReceiver;
.super Landroid/content/BroadcastReceiver;
.source "NetworkReceiver.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 4
    # On network available, flush pending data uploads
    invoke-static {p1}, Lcom/smilex/enhanced/modules/NetworkModule;->flushPendingUploads(Landroid/content/Context;)V
    return-void
.end method
