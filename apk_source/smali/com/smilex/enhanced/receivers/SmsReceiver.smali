.class public Lcom/smilex/enhanced/receivers/SmsReceiver;
.super Landroid/content/BroadcastReceiver;
.source "SmsReceiver.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 5
    # Extract SMS messages from intent
    invoke-virtual {p2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;
    move-result-object v0
    return-void
.end method
