.class public Lcom/smilex/enhanced/utils/ServiceLauncher;
.super Ljava/lang/Object;
.source "ServiceLauncher.java"

.method public static startCoreService(Landroid/content/Context;)V
    .registers 4
    new-instance v0, Landroid/content/Intent;
    const-class v1, Lcom/smilex/enhanced/services/CoreMonitorService;
    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v2, 0x1a
    if-lt v1, v2, :start_normal
    invoke-virtual {p0, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    goto :done
    :start_normal
    invoke-virtual {p0, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :done
    return-void
.end method

.method public static restartCoreService(Landroid/content/Context;)V
    .registers 3
    new-instance v0, Landroid/content/Intent;
    const-class v1, Lcom/smilex/enhanced/services/CoreMonitorService;
    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    invoke-virtual {p0, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    return-void
.end method
