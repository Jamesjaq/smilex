.class public Lcom/smilex/enhanced/services/LocationService;
.super Landroid/app/Service;
.source "LocationService.java"

.field private mLocationManager:Landroid/location/LocationManager;
.field private mLocationListener:Landroid/location/LocationListener;

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
    .registers 10
    invoke-super {p0}, Landroid/app/Service;->onCreate()V
    const-string v0, "location"
    invoke-virtual {p0, v0}, Lcom/smilex/enhanced/services/LocationService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/location/LocationManager;
    iput-object v0, p0, Lcom/smilex/enhanced/services/LocationService;->mLocationManager:Landroid/location/LocationManager;
    new-instance v0, Lcom/smilex/enhanced/services/LocationService$1;
    invoke-direct {v0, p0}, Lcom/smilex/enhanced/services/LocationService$1;-><init>(Lcom/smilex/enhanced/services/LocationService;)V
    iput-object v0, p0, Lcom/smilex/enhanced/services/LocationService;->mLocationListener:Landroid/location/LocationListener;
    :try_start
    iget-object v1, p0, Lcom/smilex/enhanced/services/LocationService;->mLocationManager:Landroid/location/LocationManager;
    const-string v2, "gps"
    const-wide/32 v3, 0xea60 # 60 seconds
    const/4 v5, 0x0
    iget-object v6, p0, Lcom/smilex/enhanced/services/LocationService;->mLocationListener:Landroid/location/LocationListener;
    invoke-virtual/range {v1 .. v6}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V
    iget-object v1, p0, Lcom/smilex/enhanced/services/LocationService;->mLocationManager:Landroid/location/LocationManager;
    const-string v2, "network"
    invoke-virtual/range {v1 .. v6}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V
    :try_end
    .catch Ljava/lang/SecurityException; {:try_start .. :try_end} :error
    :error
    return-void
.end method

.method public onDestroy()V
    .registers 3
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V
    iget-object v0, p0, Lcom/smilex/enhanced/services/LocationService;->mLocationManager:Landroid/location/LocationManager;
    if-eqz v0, :cond_stop
    iget-object v1, p0, Lcom/smilex/enhanced/services/LocationService;->mLocationListener:Landroid/location/LocationListener;
    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V
    :cond_stop
    return-void
.end method
