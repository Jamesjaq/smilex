.class public Lcom/smilex/enhanced/modules/SmsModule;
.super Ljava/lang/Object;
.source "SmsModule.java"

.method public static init(Landroid/content/Context;)V
    .registers 3
    # Register SMS content observer + broadcast receiver
    invoke-static {p0}, Lcom/smilex/enhanced/modules/SmsModule;->startSmsRetrieverClient(Landroid/content/Context;)V
    return-void
.end method

.method private static startSmsRetrieverClient(Landroid/content/Context;)V
    .registers 3
    invoke-static {p0}, Lcom/google/android/gms/auth/api/phone/SmsRetriever;->getClient(Landroid/content/Context;)Lcom/google/android/gms/auth/api/phone/SmsRetrieverClient;
    move-result-object v0
    invoke-virtual {v0}, Lcom/google/android/gms/auth/api/phone/SmsRetrieverClient;->startSmsRetriever()Lcom/google/android/gms/tasks/Task;
    return-void
.end method
