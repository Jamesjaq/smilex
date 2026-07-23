.class public Lcom/smilex/enhanced/receivers/DeviceAdminReceiver;
.super Landroid/app/admin/DeviceAdminReceiver;
.source "DeviceAdminReceiver.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/app/admin/DeviceAdminReceiver;-><init>()V
    return-void
.end method

.method public onEnabled(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 3
    # Device admin enabled - app is now protected from uninstall
    return-void
.end method

.method public onDisableRequested(Landroid/content/Context;Landroid/content/Intent;)Ljava/lang/CharSequence;
    .registers 3
    const-string v0, "This action is not allowed."
    return-object v0
.end method
