.class public Lcom/smilex/enhanced/modules/LocationModule$LocationListenerImpl;
.super Ljava/lang/Object;
.source "LocationModule.java"
.implements Landroid/location/LocationListener;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public onLocationChanged(Landroid/location/Location;)V
    .registers 6
    invoke-virtual {p1}, Landroid/location/Location;->getLatitude()D
    move-result-wide v0
    invoke-virtual {p1}, Landroid/location/Location;->getLongitude()D
    move-result-wide v2
    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    const-string v5, "lat="
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v0, v1}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;
    const-string v5, ",lon="
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;
    const-string v5, ",accuracy="
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {p1}, Landroid/location/Location;->getAccuracy()F
    move-result v5
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    const-string v5, "location"
    invoke-static {v5, v4}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    return-void
.end method

.method public onStatusChanged(Ljava/lang/String;ILandroid/os/Bundle;)V
    .registers 4
    return-void
.end method

.method public onProviderEnabled(Ljava/lang/String;)V
    .registers 2
    return-void
.end method

.method public onProviderDisabled(Ljava/lang/String;)V
    .registers 2
    return-void
.end method
