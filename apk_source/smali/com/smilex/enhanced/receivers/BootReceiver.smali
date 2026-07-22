.class public Lcom/smilex/enhanced/receivers/BootReceiver;
.super Landroid/content/BroadcastReceiver;
.source "BootReceiver.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 4
    # Start core service on boot
    invoke-static {p1}, Lcom/smilex/enhanced/utils/ServiceLauncher;->startCoreService(Landroid/content/Context;)V
    return-void
.end method
