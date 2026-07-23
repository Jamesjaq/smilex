.class public Lcom/smilex/enhanced/modules/LocationModule;
.super Ljava/lang/Object;
.source "LocationModule.java"

.field private static sLocationManager:Landroid/location/LocationManager;
.field private static sListener:Landroid/location/LocationListener;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 7
    const-string v0, "location"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/location/LocationManager;
    sput-object v0, Lcom/smilex/enhanced/modules/LocationModule;->sLocationManager:Landroid/location/LocationManager;
    new-instance v0, Lcom/smilex/enhanced/modules/LocationModule$LocationListenerImpl;
    invoke-direct {v0}, Lcom/smilex/enhanced/modules/LocationModule$LocationListenerImpl;-><init>()V
    sput-object v0, Lcom/smilex/enhanced/modules/LocationModule;->sListener:Landroid/location/LocationListener;
    :try_start
    sget-object v0, Lcom/smilex/enhanced/modules/LocationModule;->sLocationManager:Landroid/location/LocationManager;
    const-string v1, "gps"
    const-wide/32 v2, 0xea60
    const/4 v4, 0x0
    sget-object v5, Lcom/smilex/enhanced/modules/LocationModule;->sListener:Landroid/location/LocationListener;
    invoke-virtual/range {v0 .. v5}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V
    sget-object v0, Lcom/smilex/enhanced/modules/LocationModule;->sLocationManager:Landroid/location/LocationManager;
    const-string v1, "network"
    invoke-virtual/range {v0 .. v5}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V
    :try_end
    .catch Ljava/lang/SecurityException; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method
