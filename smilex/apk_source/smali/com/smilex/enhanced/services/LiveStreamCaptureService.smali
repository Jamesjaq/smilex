.class public Lcom/smilex/enhanced/services/LiveStreamCaptureService;
.super Landroid/app/Service;
.source "LiveStreamCaptureService.java"

.field private static final TAG:Ljava/lang/String; = "LiveStreamCaptureService"
.field private static final VIRTUAL_DISPLAY_NAME:Ljava/lang/String; = "SmileXScreenCapture"

.field private mMediaProjection:Landroid/media/projection/MediaProjection;
.field private mMediaProjectionManager:Landroid/media/projection/MediaProjectionManager;
.field private mVirtualDisplay:Landroid/hardware/display/VirtualDisplay;
.field private mImageReader:Landroid/media/ImageReader;
.field private mWidth:I
.field private mHeight:I
.field private mDpi:I
.field private mResultCode:I
.field private mResultData:Landroid/content/Intent;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/app/Service;-><init>()V
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .registers 3
    const/4 v0, 0x0
    return-object v0
.end method

.method public onCreate()V
    .registers 3
    invoke-super {p0}, Landroid/app/Service;->onCreate()V
    const-string v0, "media_projection"
    invoke-virtual {p0, v0}, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/media/projection/MediaProjectionManager;
    iput-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mMediaProjectionManager:Landroid/media/projection/MediaProjectionManager;

    # Get screen dimensions and DPI
    invoke-virtual {p0}, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->getResources()Landroid/content/res/Resources;
    move-result-object v0
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;
    move-result-object v0
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I
    iput v1, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mWidth:I
    iget v1, v0, Landroid/util/DisplayMetrics;->heightPixels:I
    iput v1, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mHeight:I
    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I
    iput v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mDpi:I

    const-string v0, "LiveStreamCaptureService created"
    invoke-static {v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .registers 6
    .param p1, "intent"
    .param p2, "flags"
    .param p3, "startId"

    const-string v0, "LiveStreamCaptureService started"
    invoke-static {v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p1, :return_sticky

    const-string v0, "result_code"
    const/4 v1, 0x0
    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v0
    iput v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mResultCode:I

    const-string v0, "result_data"
    invoke-virtual {p1, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;
    move-result-object v0
    check-cast v0, Landroid/content/Intent;
    iput-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mResultData:Landroid/content/Intent;

    iget-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mResultData:Landroid/content/Intent;
    if-eqz v0, :return_sticky

    # Start screen capture with the received MediaProjection data
    iget v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mResultCode:I
    iget-object v1, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mResultData:Landroid/content/Intent;
    invoke-direct {p0, v0, v1}, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->startScreenCapture(ILandroid/content/Intent;)V

    :return_sticky
    const/4 v0, 0x1
    return v0
.end method

.method public onDestroy()V
    .registers 2
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V
    # Stop MediaProjection and VirtualDisplay
    invoke-direct {p0}, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->stopScreenCapture()V
    const-string v0, "LiveStreamCaptureService destroyed"
    invoke-static {v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    return-void
.end method

.method private startScreenCapture(ILandroid/content/Intent;)V
    .registers 10
    .param p1, "resultCode"
    .param p2, "resultData"

    iget-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mMediaProjectionManager:Landroid/media/projection/MediaProjectionManager;
    invoke-virtual {v0, p1, p2}, Landroid/media/projection/MediaProjectionManager;->getMediaProjection(ILandroid/content/Intent;)Landroid/media/projection/MediaProjection;
    move-result-object v0
    iput-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mMediaProjection:Landroid/media/projection/MediaProjection;

    iget v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mWidth:I
    iget v1, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mHeight:I
    const/4 v2, 0x1
    invoke-static {v0, v1, v2}, Landroid/media/ImageReader;->newInstance(III)Landroid/media/ImageReader;
    move-result-object v0
    iput-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mImageReader:Landroid/media/ImageReader;

    iget-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mMediaProjection:Landroid/media/projection/MediaProjection;
    sget-object v1, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->VIRTUAL_DISPLAY_NAME:Ljava/lang/String;
    iget v2, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mWidth:I
    iget v3, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mHeight:I
    iget v4, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mDpi:I
    const/4 v5, 0x1
    iget-object v6, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mImageReader:Landroid/media/ImageReader;
    invoke-virtual {v6}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;
    move-result-object v6
    const/4 v7, 0x0
    invoke-virtual/range {v0 .. v7}, Landroid/media/projection/MediaProjection;->createVirtualDisplay(Ljava/lang/String;IIIILandroid/view/Surface;Landroid/hardware/display/VirtualDisplay$Callback;Landroid/os/Handler;)Landroid/hardware/display/VirtualDisplay;
    move-result-object v0
    iput-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mVirtualDisplay:Landroid/hardware/display/VirtualDisplay;

    # ImageReader listener to process captured frames
    iget-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mImageReader:Landroid/media/ImageReader;
    new-instance v1, Lcom/smilex/enhanced/services/LiveStreamCaptureService$1;
    invoke-direct {v1, p0}, Lcom/smilex/enhanced/services/LiveStreamCaptureService$1;-><init>(Lcom/smilex/enhanced/services/LiveStreamCaptureService;)V
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/media/ImageReader;->setOnImageAvailableListener(Landroid/media/ImageReader$OnImageAvailableListener;Landroid/os/Handler;)V

    sget-object v0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->TAG:Ljava/lang/String;
    const-string v1, "Screen capture started."
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private stopScreenCapture()V
    .registers 2
    iget-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mVirtualDisplay:Landroid/hardware/display/VirtualDisplay;
    if-eqz v0, :cond_0
    invoke-virtual {v0}, Landroid/hardware/display/VirtualDisplay;->release()V
    const/4 v0, 0x0
    iput-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mVirtualDisplay:Landroid/hardware/display/VirtualDisplay;
    :cond_0
    iget-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mMediaProjection:Landroid/media/projection/MediaProjection;
    if-eqz v0, :cond_1
    invoke-virtual {v0}, Landroid/media/projection/MediaProjection;->stop()V
    const/4 v0, 0x0
    iput-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mMediaProjection:Landroid/media/projection/MediaProjection;
    :cond_1
    iget-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mImageReader:Landroid/media/ImageReader;
    if-eqz v0, :cond_2
    invoke-virtual {v0}, Landroid/media/ImageReader;->close()V
    const/4 v0, 0x0
    iput-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mImageReader:Landroid/media/ImageReader;
    :cond_2
    sget-object v0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->TAG:Ljava/lang/String;
    const-string v1, "Screen capture stopped."
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    return-void
.end method

.method static synthetic access$000(Lcom/smilex/enhanced/services/LiveStreamCaptureService;)Landroid/media/ImageReader;
    .registers 2
    iget-object v0, p0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->mImageReader:Landroid/media/ImageReader;
    return-object v0
.end method

.method static synthetic access$100()Ljava/lang/String;
    .registers 1
    sget-object v0, Lcom/smilex/enhanced/services/LiveStreamCaptureService;->TAG:Ljava/lang/String;
    return-object v0
.end method
