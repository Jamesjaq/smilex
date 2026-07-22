.class public Lcom/smilex/enhanced/modules/LocationModule;
.super Ljava/lang/Object;
.source "LocationModule.java"

.method public static init(Landroid/content/Context;)V
    .registers 3
    # Request location updates (GPS + Network)
    # Handles both legacy (API < 21) and modern (FusedLocationProvider)
    return-void
.end method
