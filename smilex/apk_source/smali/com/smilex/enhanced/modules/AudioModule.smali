.class public Lcom/smilex/enhanced/modules/AudioModule;
.super Ljava/lang/Object;
.source "AudioModule.java"

.field private static sRecorder:Landroid/media/MediaRecorder;
.field private static sIsRecording:Z

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 2
    return-void
.end method

.method public static startRecording(Landroid/content/Context;)V
    .registers 6
    sget-boolean v0, Lcom/smilex/enhanced/modules/AudioModule;->sIsRecording:Z
    if-eqz v0, :return
    new-instance v0, Landroid/media/MediaRecorder;
    invoke-direct {v0}, Landroid/media/MediaRecorder;-><init>()V
    sput-object v0, Lcom/smilex/enhanced/modules/AudioModule;->sRecorder:Landroid/media/MediaRecorder;
    :try_start
    sget-object v0, Lcom/smilex/enhanced/modules/AudioModule;->sRecorder:Landroid/media/MediaRecorder;
    const/4 v1, 0x1
    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setAudioSource(I)V
    sget-object v0, Lcom/smilex/enhanced/modules/AudioModule;->sRecorder:Landroid/media/MediaRecorder;
    const/4 v1, 0x3
    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setOutputFormat(I)V
    sget-object v0, Lcom/smilex/enhanced/modules/AudioModule;->sRecorder:Landroid/media/MediaRecorder;
    const/4 v1, 0x1
    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setAudioEncoder(I)V
    new-instance v0, Ljava/io/File;
    invoke-virtual {p0}, Landroid/content/Context;->getExternalCacheDir()Ljava/io/File;
    move-result-object v1
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "audio_"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v3
    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    const-string v3, ".m4a"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    sget-object v1, Lcom/smilex/enhanced/modules/AudioModule;->sRecorder:Landroid/media/MediaRecorder;
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroid/media/MediaRecorder;->setOutputFile(Ljava/lang/String;)V
    sget-object v1, Lcom/smilex/enhanced/modules/AudioModule;->sRecorder:Landroid/media/MediaRecorder;
    invoke-virtual {v1}, Landroid/media/MediaRecorder;->prepare()V
    sget-object v1, Lcom/smilex/enhanced/modules/AudioModule;->sRecorder:Landroid/media/MediaRecorder;
    invoke-virtual {v1}, Landroid/media/MediaRecorder;->start()V
    const/4 v1, 0x1
    sput-boolean v1, Lcom/smilex/enhanced/modules/AudioModule;->sIsRecording:Z
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method

.method public static stopRecording()V
    .registers 3
    sget-boolean v0, Lcom/smilex/enhanced/modules/AudioModule;->sIsRecording:Z
    if-eqz v0, :return
    :try_start
    sget-object v0, Lcom/smilex/enhanced/modules/AudioModule;->sRecorder:Landroid/media/MediaRecorder;
    invoke-virtual {v0}, Landroid/media/MediaRecorder;->stop()V
    sget-object v0, Lcom/smilex/enhanced/modules/AudioModule;->sRecorder:Landroid/media/MediaRecorder;
    invoke-virtual {v0}, Landroid/media/MediaRecorder;->release()V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    const/4 v0, 0x0
    sput-boolean v0, Lcom/smilex/enhanced/modules/AudioModule;->sIsRecording:Z
    const/4 v0, 0x0
    sput-object v0, Lcom/smilex/enhanced/modules/AudioModule;->sRecorder:Landroid/media/MediaRecorder;
    return-void
.end method
