.class Lcom/smilex/client/services/ClientC2Service$1;
.super Ljava/lang/Object;
.source "ClientC2Service.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smilex/client/services/ClientC2Service;->onStartCommand(Landroid/content/Intent;II)I
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "1"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/smilex/client/services/ClientC2Service;


# direct methods
.method constructor <init>(Lcom/smilex/client/services/ClientC2Service;)V
    .registers 2
    .param p1, "this$0"

    iput-object p1, p0, Lcom/smilex/client/services/ClientC2Service$1;->this$0:Lcom/smilex/client/services/ClientC2Service;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method


# virtual methods
.method public run()V
    .registers 4
    # Simulate network operation: sending command, receiving data
    :try_start_0
    const-wide/16 v0, 0x1388
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V

    sget-object v0, Lcom/smilex/client/services/ClientC2Service;->TAG:Ljava/lang/String;
    const-string v1, "Simulating C2 communication..."
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    # Example: Send a command to the C2 server
    # URL: C2_SERVER_URL + "command"
    # Data: JSON payload with command and target ID

    # Example: Receive data from the C2 server
    # URL: C2_SERVER_URL + "data"
    # Response: JSON payload with monitored data

    # Update UI (if connected to Activity)
    # This would typically be done via BroadcastReceiver or EventBus

    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V
    return-void
.end method
