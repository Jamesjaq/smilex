.class public Lcom/smilex/enhanced/modules/AppUsageModule;
.super Ljava/lang/Object;
.source "AppUsageModule.java"

.method public static init(Landroid/content/Context;)V
    .registers 3
    # Use UsageStatsManager (API 21+) or ActivityManager.getRunningTasks (API < 21)
    return-void
.end method
