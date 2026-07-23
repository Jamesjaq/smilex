.class public Lcom/smilex/enhanced/utils/CryptoUtils;
.super Ljava/lang/Object;
.source "CryptoUtils.java"

.field private static final ALGORITHM:Ljava/lang/String; = "AES"
.field private static final TRANSFORMATION:Ljava/lang/String; = "AES/CBC/PKCS5Padding"
.field private static final PREF_NAME:Ljava/lang/String; = "smilex_crypto"
.field private static final KEY_PREF:Ljava/lang/String; = "aes_key"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static encrypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 9
    :try_start
    new-instance v0, Ljavax/crypto/spec/SecretKeySpec;
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B
    move-result-object v1
    const-string v2, "AES"
    invoke-direct {v0, v1, v2}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    new-instance v1, Ljavax/crypto/spec/IvParameterSpec;
    const-string v2, "0102030405060708"
    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B
    move-result-object v2
    invoke-direct {v1, v2}, Ljavax/crypto/spec/IvParameterSpec;-><init>([B)V

    const-string v2, "AES/CBC/PKCS5Padding"
    invoke-static {v2}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;
    move-result-object v2

    const/4 v3, 0x1
    invoke-virtual {v2, v3, v0, v1}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B
    move-result-object v3
    invoke-virtual {v2, v3}, Ljavax/crypto/Cipher;->doFinal([B)[B
    move-result-object v3

    # FIX: Base64.encodeToString([B, int) requires flags — use Base64.DEFAULT (0)
    const/4 v5, 0x0
    invoke-static {v3, v5}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;
    move-result-object v4
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    return-object v4

    :error
    move-exception v0
    const-string v1, "CryptoUtils"
    const-string v2, "Encryption failed"
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    return-object p0
.end method

.method public static decrypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 9
    :try_start
    new-instance v0, Ljavax/crypto/spec/SecretKeySpec;
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B
    move-result-object v1
    const-string v2, "AES"
    invoke-direct {v0, v1, v2}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    new-instance v1, Ljavax/crypto/spec/IvParameterSpec;
    const-string v2, "0102030405060708"
    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B
    move-result-object v2
    invoke-direct {v1, v2}, Ljavax/crypto/spec/IvParameterSpec;-><init>([B)V

    const-string v2, "AES/CBC/PKCS5Padding"
    invoke-static {v2}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;
    move-result-object v2

    const/4 v3, 0x2
    invoke-virtual {v2, v3, v0, v1}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    # FIX: Base64.decode(String, int) requires flags — use Base64.DEFAULT (0)
    const/4 v3, 0x0
    invoke-static {p0, v3}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B
    move-result-object v3
    invoke-virtual {v2, v3}, Ljavax/crypto/Cipher;->doFinal([B)[B
    move-result-object v3

    new-instance v4, Ljava/lang/String;
    invoke-direct {v4, v3}, Ljava/lang/String;-><init>([B)V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    return-object v4

    :error
    move-exception v0
    const-string v1, "CryptoUtils"
    const-string v2, "Decryption failed"
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    return-object p0
.end method

.method public static getOrCreateKey(Landroid/content/Context;)Ljava/lang/String;
    .registers 5
    const-string v0, "smilex_crypto"
    const/4 v1, 0x0
    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0

    const-string v1, "aes_key"
    const/4 v2, 0x0
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1

    if-eqz v1, :new_key
    invoke-virtual {v1}, Ljava/lang/String;->length()I
    move-result v2
    const/16 v3, 0x10
    if-ge v2, v3, :return

    :new_key
    new-instance v2, Ljava/security/SecureRandom;
    invoke-direct {v2}, Ljava/security/SecureRandom;-><init>()V

    new-array v3, v3, [B
    invoke-virtual {v2, v3}, Ljava/security/SecureRandom;->nextBytes([B)V

    # FIX: Base64.encodeToString([B, int) requires flags — use Base64.DEFAULT (0)
    const/4 v4, 0x0
    invoke-static {v3, v4}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;
    move-result-object v1

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v2
    const-string v3, "aes_key"
    invoke-interface {v2, v3, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->apply()V

    :return
    return-object v1
.end method

.method public static generateDeviceId(Landroid/content/Context;)Ljava/lang/String;
    .registers 5
    :try_start
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v0
    const-string v1, "android_id"
    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0

    if-eqz v0, :new_id
    invoke-virtual {v0}, Ljava/lang/String;->length()I
    move-result v1
    if-lez v1, :new_id

    :return_id
    return-object v0

    :new_id
    new-instance v1, Ljava/util/UUID;
    invoke-direct {v1}, Ljava/util/UUID;-><init>()V
    invoke-virtual {v1}, Ljava/util/UUID;->toString()Ljava/lang/String;
    move-result-object v1
    move-object v0, v1
    goto :return_id
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    return-object v0

    :error
    move-exception v0
    new-instance v1, Ljava/util/UUID;
    invoke-direct {v1}, Ljava/util/UUID;-><init>()V
    invoke-virtual {v1}, Ljava/util/UUID;->toString()Ljava/lang/String;
    move-result-object v1
    return-object v1
.end method
