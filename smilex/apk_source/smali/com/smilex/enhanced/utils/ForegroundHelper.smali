.class public Lcom/smilex/enhanced/utils/ForegroundHelper;
.super Ljava/lang/Object;
.source "ForegroundHelper.java"

.method public static startForeground(Landroid/app/Service;)V
    .registers 8
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x1a
    if-lt v0, v1, :skip_foreground
    const-string v1, "smilex_channel"
    const-string v2, "System Service"
    const/4 v3, 0x3
    const-string v4, "notification"
    invoke-virtual {p0, v4}, Landroid/app/Service;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v4
    check-cast v4, Landroid/app/NotificationManager;
    new-instance v5, Landroid/app/NotificationChannel;
    invoke-direct {v5, v1, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V
    invoke-virtual {v4, v5}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V
    new-instance v5, Landroid/app/Notification$Builder;
    invoke-direct {v5, p0, v1}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V
    const-string v6, "System Service"
    invoke-virtual {v5, v6}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    move-result-object v5
    const-string v6, "Running..."
    invoke-virtual {v5, v6}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    move-result-object v5
    invoke-virtual {v5}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;
    move-result-object v6
    const/4 v7, 0x1
    invoke-virtual {p0, v7, v6}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;)V
    :skip_foreground
    return-void
.end method
