.class public Lcom/smilex/enhanced/receivers/AlarmReceiver;
.super Landroid/content/BroadcastReceiver;
.source "AlarmReceiver.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 4
    # Periodic: collect data, upload, restart service if needed
    invoke-static {p1}, Lcom/smilex/enhanced/utils/ServiceLauncher;->startCoreService(Landroid/content/Context;)V
    return-void
.end method
