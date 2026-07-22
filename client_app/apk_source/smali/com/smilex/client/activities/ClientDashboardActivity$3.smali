.class Lcom/smilex/client/activities/ClientDashboardActivity$3;
.super Ljava/lang/Object;
.source "ClientDashboardActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smilex/client/activities/ClientDashboardActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "3"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/smilex/client/activities/ClientDashboardActivity;


# direct methods
.method constructor <init>(Lcom/smilex/client/activities/ClientDashboardActivity;)V
    .registers 2
    .param p1, "this$0"

    iput-object p1, p0, Lcom/smilex/client/activities/ClientDashboardActivity$3;->this$0:Lcom/smilex/client/activities/ClientDashboardActivity;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 2
    .param p1, "v"

    iget-object p1, p0, Lcom/smilex/client/activities/ClientDashboardActivity$3;->this$0:Lcom/smilex/client/activities/ClientDashboardActivity;
    invoke-static {p1}, Lcom/smilex/client/activities/ClientDashboardActivity;->access$100(Lcom/smilex/client/activities/ClientDashboardActivity;)Landroid/widget/TextView;
    move-result-object p1
    const-string v0, "Starting live stream..."
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    iget-object p1, p0, Lcom/smilex/client/activities/ClientDashboardActivity$3;->this$0:Lcom/smilex/client/activities/ClientDashboardActivity;
    invoke-static {p1}, Lcom/smilex/client/activities/ClientDashboardActivity;->access$400(Lcom/smilex/client/activities/ClientDashboardActivity;)V
    return-void
.end method
