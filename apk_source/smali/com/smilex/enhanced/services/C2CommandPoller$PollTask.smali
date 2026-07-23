.class Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;
.super Ljava/util/TimerTask;
.source "C2CommandPoller.java"

.field final synthetic this$0:Lcom/smilex/enhanced/services/C2CommandPoller;

.method constructor <init>(Lcom/smilex/enhanced/services/C2CommandPoller;)V
    .registers 2
    iput-object p1, p0, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;->this$0:Lcom/smilex/enhanced/services/C2CommandPoller;
    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V
    return-void
.end method

.method public run()V
    .registers 3
    iget-object v0, p0, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;->this$0:Lcom/smilex/enhanced/services/C2CommandPoller;
    invoke-static {v0}, Lcom/smilex/enhanced/services/C2CommandPoller;->access$000(Lcom/smilex/enhanced/services/C2CommandPoller;)V

    new-instance v0, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask$1;
    invoke-direct {v1, p0}, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask$1;-><init>(Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
