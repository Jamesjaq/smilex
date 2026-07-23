.class Lcom/smilex/enhanced/services/LiveStreamCaptureService$1;
.super Ljava/lang/Object;
.source "LiveStreamCaptureService.java"

.implements Landroid/media/ImageReader$OnImageAvailableListener;

.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smilex/enhanced/services/LiveStreamCaptureService;->startScreenCapture(ILandroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "1"
.end annotation

.field final synthetic this$0:Lcom/smilex/enhanced/services/LiveStreamCaptureService;
.field private mFrameCount:I
.field private mLastFrameTime:J

.method constructor <init>(Lcom/smilex/enhanced/services/LiveStreamCaptureService;)V
    .registers 3
    iput-object p1, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService$1;->this$0:Lcom/smilex/enhanced/services/LiveStreamCaptureService;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    const/4 v0, 0x0
    iput v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService$1;->mFrameCount:I
    const-wide/16 v0, 0x0
    iput-wide v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService$1;->mLastFrameTime:J
    return-void
.end method

.method public onImageAvailable(Landroid/media/ImageReader;)V
    .registers 16
    .param p1, "reader"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v0

    iget-wide v2, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService$1;->mLastFrameTime:J
    sub-long v2, v0, v2
    const-wide/16 v4, 0x64

    cmp-long v2, v2, v4
    if-gez v2, :skip_frame

    invoke-virtual {p1}, Landroid/media/ImageReader;->acquireLatestImage()Landroid/media/Image;
    move-result-object v2

    if-eqz v2, :skip_frame

    :try_start
    invoke-virtual {v2}, Landroid/media/Image;->getWidth()I
    move-result v3

    invoke-virtual {v2}, Landroid/media/Image;->getHeight()I
    move-result v4

    invoke-virtual {v2}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;
    move-result-object v5

    const/4 v6, 0x0
    aget-object v5, v5, v6

    invoke-virtual {v5}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;
    move-result-object v5

    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->remaining()I
    move-result v6
    new-array v6, v6, [B

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->get([B)V

    new-instance v7, Landroid/graphics/BitmapFactory$Options;
    invoke-direct {v7}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    sget-object v8, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;
    iput-object v8, v7, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    const/4 v8, 0x0
    array-length v9, v6
    invoke-static {v6, v8, v9, v7}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;
    move-result-object v8

    if-eqz v8, :close_image

    new-instance v9, Ljava/io/ByteArrayOutputStream;
    invoke-direct {v9}, Ljava/io/ByteArrayOutputStream;-><init>()V

    sget-object v10, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;
    const/16 v11, 0x50
    invoke-virtual {v8, v10, v11, v9}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    invoke-virtual {v9}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B
    move-result-object v10

    array-length v11, v10

    new-instance v12, Ljava/lang/StringBuilder;
    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "frame="
    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v10}, Landroid/util/Base64;->encodeToString([B)Ljava/lang/String;
    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v13, "&w="
    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v13, "&h="
    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v12

    const-string v13, "livestream"
    invoke-static {v13, v12}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v8}, Landroid/graphics/Bitmap;->recycle()V

    iput-wide v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService$1;->mLastFrameTime:J

    iget v13, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService$1;->mFrameCount:I
    add-int/lit8 v13, v13, 0x1
    iput v13, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService$1;->mFrameCount:I

    :close_image
    invoke-virtual {v2}, Landroid/media/Image;->close()V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch

    :skip_frame
    return-void
.end method
