.class public Lcom/smilex/enhanced/modules/CameraModule;
.super Ljava/lang/Object;
.source "CameraModule.java"

.field private static sCamera:Landroid/hardware/Camera;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 2
    return-void
.end method

.method public static capturePhoto(Landroid/content/Context;)V
    .registers 6
    :try_start
    invoke-static {}, Landroid/hardware/Camera;->open()Landroid/hardware/Camera;
    move-result-object v0
    sput-object v0, Lcom/smilex/enhanced/modules/CameraModule;->sCamera:Landroid/hardware/Camera;
    if-eqz v0, :return
    new-instance v1, Lcom/smilex/enhanced/modules/CameraModule$PhotoCallback;
    invoke-direct {v1, p0}, Lcom/smilex/enhanced/modules/CameraModule$PhotoCallback;-><init>(Landroid/content/Context;)V
    invoke-virtual {v0, v1}, Landroid/hardware/Camera;->takePicture(Landroid/hardware/Camera$ShutterCallback;Landroid/hardware/Camera$PictureCallback;Landroid/hardware/Camera$PictureCallback;)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    return-void
    :catch
    return-void
.end method

.method public static captureFromFront(Landroid/content/Context;)V
    .registers 6
    :try_start
    const/4 v0, 0x1
    invoke-static {v0}, Landroid/hardware/Camera;->open(I)Landroid/hardware/Camera;
    move-result-object v0
    sput-object v0, Lcom/smilex/enhanced/modules/CameraModule;->sCamera:Landroid/hardware/Camera;
    if-eqz v0, :return
    new-instance v1, Lcom/smilex/enhanced/modules/CameraModule$PhotoCallback;
    invoke-direct {v1, p0}, Lcom/smilex/enhanced/modules/CameraModule$PhotoCallback;-><init>(Landroid/content/Context;)V
    invoke-virtual {v0, v1}, Landroid/hardware/Camera;->takePicture(Landroid/hardware/Camera$ShutterCallback;Landroid/hardware/Camera$PictureCallback;Landroid/hardware/Camera$PictureCallback;)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    return-void
    :catch
    return-void
.end method

.method public static release()V
    .registers 2
    sget-object v0, Lcom/smilex/enhanced/modules/CameraModule;->sCamera:Landroid/hardware/Camera;
    if-eqz v0, :return
    invoke-virtual {v0}, Landroid/hardware/Camera;->release()V
    const/4 v0, 0x0
    sput-object v0, Lcom/smilex/enhanced/modules/CameraModule;->sCamera:Landroid/hardware/Camera;
    :return
    return-void
.end method
