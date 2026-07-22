.class public Lcom/smilex/enhanced/services/NotificationListenerService;
.super Landroid/service/notification/NotificationListenerService;
.source "NotificationListenerService.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/service/notification/NotificationListenerService;-><init>()V
    return-void
.end method

.method public onNotificationPosted(Landroid/service/notification/StatusBarNotification;)V
    .registers 4
    # Capture notification content from all apps
    invoke-virtual {p1}, Landroid/service/notification/StatusBarNotification;->getPackageName()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {p1}, Landroid/service/notification/StatusBarNotification;->getNotification()Landroid/app/Notification;
    move-result-object v1
    return-void
.end method
