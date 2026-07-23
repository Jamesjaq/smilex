.class public Lcom/smilex/enhanced/modules/SmsModule$SmsContentObserver;
.super Landroid/database/ContentObserver;
.source "SmsModule.java"

.field final synthetic val$context:Landroid/content/Context;

.method public constructor <init>(Landroid/os/Handler;Landroid/content/Context;)V
    .registers 3
    iput-object p2, p0, Lcom/smilex/enhanced/modules/SmsModule$SmsContentObserver;->val$context:Landroid/content/Context;
    invoke-direct {p0, p1}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V
    return-void
.end method

.method public onChange(Z)V
    .registers 3
    invoke-super {p0, p1}, Landroid/database/ContentObserver;->onChange(Z)V
    iget-object v0, p0, Lcom/smilex/enhanced/modules/SmsModule$SmsContentObserver;->val$context:Landroid/content/Context;
    invoke-static {v0}, Lcom/smilex/enhanced/modules/SmsModule;->readAllSms(Landroid/content/Context;)V
    return-void
.end method
