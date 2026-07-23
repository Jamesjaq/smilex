.class public Lcom/smilex/enhanced/modules/CallModule;
.super Ljava/lang/Object;
.source "CallModule.java"

.field private static sTelephonyManager:Landroid/telephony/TelephonyManager;
.field private static sPhoneStateListener:Landroid/telephony/PhoneStateListener;
.field private static sLastState:I

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 5
    const-string v0, "phone"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/telephony/TelephonyManager;
    sput-object v0, Lcom/smilex/enhanced/modules/CallModule;->sTelephonyManager:Landroid/telephony/TelephonyManager;
    const/4 v1, 0x0
    sput v1, Lcom/smilex/enhanced/modules/CallModule;->sLastState:I
    new-instance v1, Lcom/smilex/enhanced/modules/CallModule$PhoneStateListenerImpl;
    invoke-direct {v1}, Lcom/smilex/enhanced/modules/CallModule$PhoneStateListenerImpl;-><init>()V
    sput-object v1, Lcom/smilex/enhanced/modules/CallModule;->sPhoneStateListener:Landroid/telephony/PhoneStateListener;
    :try_start
    sget-object v0, Lcom/smilex/enhanced/modules/CallModule;->sTelephonyManager:Landroid/telephony/TelephonyManager;
    sget-object v1, Lcom/smilex/enhanced/modules/CallModule;->sPhoneStateListener:Landroid/telephony/PhoneStateListener;
    const/16 v2, 0x20
    invoke-virtual {v0, v1, v2}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V
    :try_end
    .catch Ljava/lang/SecurityException; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method

.method public static startRecording()V
    .registers 3
    new-instance v0, Landroid/content/Intent;
    invoke-direct {v0}, Landroid/content/Intent;-><init>()V
    const-string v1, "action"
    const-string v2, "START_RECORDING"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    return-void
.end method

.method public static stopRecording()V
    .registers 3
    new-instance v0, Landroid/content/Intent;
    invoke-direct {v0}, Landroid/content/Intent;-><init>()V
    const-string v1, "action"
    const-string v2, "STOP_RECORDING"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    return-void
.end method
