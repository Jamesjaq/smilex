.class Lcom/smilex/enhanced/services/LocationService$1;
.super Ljava/lang/Object;
.source "LocationService.java"
.implements Landroid/location/LocationListener;

.field final synthetic this$0:Lcom/smilex/enhanced/services/LocationService;

.method constructor <init>(Lcom/smilex/enhanced/services/LocationService;)V
    .registers 2
    iput-object p1, p0, Lcom/smilex/enhanced/services/LocationService$1;->this$0:Lcom/smilex/enhanced/services/LocationService;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public onLocationChanged(Landroid/location/Location;)V
    .registers 4
    # Log location data or send to NetworkModule
    invoke-virtual {p1}, Landroid/location/Location;->getLatitude()D
    move-result-wide v0
    invoke-virtual {p1}, Landroid/location/Location;->getLongitude()D
    move-result-wide v0
    return-void
.end method

.method public onStatusChanged(Ljava/lang/String;ILandroid/os/Bundle;)V
    .registers 4
    return-void
.end method

.method public onProviderEnabled(Ljava/lang/String;)V
    .registers 4
    return-void
.end method

.method public onProviderDisabled(Ljava/lang/String;)V
    .registers 4
    return-void
.end method
