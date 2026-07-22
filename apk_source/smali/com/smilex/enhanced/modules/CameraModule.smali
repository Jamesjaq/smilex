.class public Lcom/smilex/enhanced/modules/CameraModule;
.super Ljava/lang/Object;
.source "CameraModule.java"

.method public static init(Landroid/content/Context;)V
    .registers 3
    # Use Camera2 API (API 21+) or legacy Camera API (API < 21)
    # Silent capture with 1x1 transparent SurfaceTexture
    return-void
.end method
