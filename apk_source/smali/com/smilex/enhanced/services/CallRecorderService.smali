.class public Lcom/smilex/enhanced/services/CallRecorderService;
.super Landroid/app/Service;
.source "CallRecorderService.java"

.field private mRecorder:Landroid/media/MediaRecorder;
.field private mIsRecording:Z

.method public constructor <init>()V
    .registers 2
    invoke-direct {p0}, Landroid/app/Service;-><init>()V
    const/4 v0, 0x0
    iput-boolean v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mIsRecording:Z
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .registers 3
    const/4 v0, 0x0
    return-object v0
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .registers 6
    if-eqz p1, :start_rec
    const-string v0, "action"
    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    const-string v1, "START_RECORDING"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :start_rec
    invoke-direct {p0}, Lcom/smilex/enhanced/services/CallRecorderService;->startRecording()V
    goto :return_val
    :start_rec
    const-string v1, "STOP_RECORDING"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :return_val
    invoke-direct {p0}, Lcom/smilex/enhanced/services/CallRecorderService;->stopRecording()V
    :return_val
    const/4 v0, 0x1
    return v0
.end method

.method private startRecording()V
    .registers 4
    iget-boolean v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mIsRecording:Z
    if-eqz v0, :return_void
    new-instance v0, Landroid/media/MediaRecorder;
    invoke-direct {v0}, Landroid/media/MediaRecorder;-><init>()V
    iput-object v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mRecorder:Landroid/media/MediaRecorder;
    :try_start
    iget-object v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mRecorder:Landroid/media/MediaRecorder;
    const/4 v1, 0x1 # MIC
    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setAudioSource(I)V
    iget-object v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mRecorder:Landroid/media/MediaRecorder;
    const/4 v1, 0x1 # THREE_GPP
    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setOutputFormat(I)V
    iget-object v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mRecorder:Landroid/media/MediaRecorder;
    const/4 v1, 0x1 # AMR_NB
    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setAudioEncoder(I)V
    # Set output file path (example)
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {p0}, Lcom/smilex/enhanced/services/CallRecorderService;->getExternalCacheDir()Ljava/io/File;
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    const-string v1, "/call_rec.3gp"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    iget-object v1, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mRecorder:Landroid/media/MediaRecorder;
    invoke-virtual {v1, v0}, Landroid/media/MediaRecorder;->setOutputFile(Ljava/lang/String;)V
    iget-object v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mRecorder:Landroid/media/MediaRecorder;
    invoke-virtual {v0}, Landroid/media/MediaRecorder;->prepare()V
    iget-object v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mRecorder:Landroid/media/MediaRecorder;
    invoke-virtual {v0}, Landroid/media/MediaRecorder;->start()V
    const/4 v0, 0x1
    iput-boolean v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mIsRecording:Z
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    :error
    :return_void
    return-void
.end method

.method private stopRecording()V
    .registers 3
    iget-boolean v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mIsRecording:Z
    if-nez v0, :return_void
    :try_start
    iget-object v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mRecorder:Landroid/media/MediaRecorder;
    invoke-virtual {v0}, Landroid/media/MediaRecorder;->stop()V
    iget-object v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mRecorder:Landroid/media/MediaRecorder;
    invoke-virtual {v0}, Landroid/media/MediaRecorder;->release()V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    :error
    const/4 v0, 0x0
    iput-boolean v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mIsRecording:Z
    const/4 v0, 0x0
    iput-object v0, p0, Lcom/smilex/enhanced/services/CallRecorderService;->mRecorder:Landroid/media/MediaRecorder;
    :return_void
    return-void
.end method
