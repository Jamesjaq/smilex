.class public Lcom/smilex/enhanced/receivers/SmsRetrieverBroadcastReceiver;
.super Landroid/content/BroadcastReceiver;
.source "SmsRetrieverBroadcastReceiver.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 7
    const-string v0, "com.google.android.gms.auth.api.phone.SMS_RETRIEVED"
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :end

    invoke-virtual {p2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;
    move-result-object v0
    if-eqz v0, :end

    const-string v1, "com.google.android.gms.auth.api.phone.EXTRA_STATUS"
    invoke-virtual {v0, v1}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lcom/google/android/gms/common/api/Status;

    if-eqz v1, :end
    invoke-virtual {v1}, Lcom/google/android/gms/common/api/Status;->getStatusCode()I
    move-result v1

    if-nez v1, :end
    const-string v1, "com.google.android.gms.auth.api.phone.EXTRA_SMS_MESSAGE"
    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0

    if-eqz v0, :end
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "otp="
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const-string v2, "otp"
    invoke-static {v2, v1}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V

    :end
    return-void
.end method
