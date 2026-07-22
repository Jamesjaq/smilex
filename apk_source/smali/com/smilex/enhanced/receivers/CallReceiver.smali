.class public Lcom/smilex/enhanced/receivers/CallReceiver;
.super Landroid/content/BroadcastReceiver;
.source "CallReceiver.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 5
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;
    move-result-object v0
    # Handle PHONE_STATE and NEW_OUTGOING_CALL
    return-void
.end method
