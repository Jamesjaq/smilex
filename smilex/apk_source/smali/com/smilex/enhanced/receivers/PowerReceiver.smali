.class public Lcom/smilex/enhanced/receivers/PowerReceiver;
.super Landroid/content/BroadcastReceiver;
.source "PowerReceiver.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 6
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :return
    const-string v1, "android.intent.action.BATTERY_LOW"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_charged
    const-string v1, "battery_event"
    const-string v2, "level=low"
    invoke-static {v1, v2}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    goto :return
    :check_charged
    const-string v1, "android.intent.action.BATTERY_OKAY"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_power
    const-string v1, "battery_event"
    const-string v2, "level=okay"
    invoke-static {v1, v2}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    goto :return
    :check_power
    const-string v1, "android.intent.action.ACTION_POWER_CONNECTED"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_disconnect
    const-string v1, "battery_event"
    const-string v2, "power=connected"
    invoke-static {v1, v2}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    goto :return
    :check_disconnect
    const-string v1, "android.intent.action.ACTION_POWER_DISCONNECTED"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :return
    const-string v1, "battery_event"
    const-string v2, "power=disconnected"
    invoke-static {v1, v2}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    :return
    return-void
.end method
