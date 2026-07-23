.class public Lcom/smilex/enhanced/receivers/AirplaneModeReceiver;
.super Landroid/content/BroadcastReceiver;
.source "AirplaneModeReceiver.java"

# Ported from hwapp391 persistence mechanism
# Restarts the core service when airplane mode is toggled off,
# ensuring persistence across connectivity interruptions.

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 5
    const-string v0, "android.intent.action.AIRPLANE_MODE"
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :return

    # Only restart when airplane mode is turned OFF (state = false)
    const-string v0, "state"
    const/4 v2, 0x0
    invoke-virtual {p2, v0, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z
    move-result v0
    if-nez v0, :return

    # Airplane mode turned off — restart core service for persistence
    invoke-static {p1}, Lcom/smilex/enhanced/utils/ServiceLauncher;->startCoreService(Landroid/content/Context;)V

    :return
    return-void
.end method
