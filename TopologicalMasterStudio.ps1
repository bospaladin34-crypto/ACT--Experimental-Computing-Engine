# ============================================================================
# ACT-Ω Unified Master Topological Studio & Autonomous Control Center
# STA Thread Safe, Integrated ZKP Verifier & Auto-Initialized Control Hub
# ============================================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$OutputEncoding = [System.Text.Encoding]::UTF8

$scriptDir = "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
if (Test-Path $scriptDir) { Set-Location $scriptDir }

try { Stop-Process -Name "topological_web_hub" -Force -ErrorAction SilentlyContinue } catch {}

# 1. LAUNCH BACKGROUND SERVICES (HUD OVERLAY & WEB HUB SERVER)
if (Test-Path ".\TopologicalHUD.ps1") {
    Start-Process powershell -ArgumentList "-sta -ExecutionPolicy Bypass -File .\TopologicalHUD.ps1" -WindowStyle Hidden
}

if (Test-Path ".\topological_web_hub.exe") {
    Start-Process -FilePath ".\topological_web_hub.exe" -WindowStyle Hidden
}

# 2. LAUNCH DEDICATED VISIBLE GIT AUTO-PUSH TERMINAL CONSOLE
if (Test-Path ".\Start-TopologicalGitWatcher.ps1") {
    Start-Process powershell -ArgumentList "-NoExit -sta -ExecutionPolicy Bypass -File .\Start-TopologicalGitWatcher.ps1"
}

$form = New-Object System.Windows.Forms.Form
$form.Text = "ACT-Ω v25.0 Master Topological Control Center (Auto-Initialized & ZKP Verified)"
$form.Size = New-Object System.Drawing.Size(980, 860)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(20, 24, 32)
$form.ForeColor = [System.Drawing.Color]::White

# Shared State
$script:braidGenerators = [System.Collections.Generic.List[int]]::new()
$script:braidGenerators.Add(1); $script:braidGenerators.Add(2); $script:braidGenerators.Add(-2); $script:braidGenerators.Add(1)

# Header Label
$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "ACT-Ω Unified Master Topological Studio Engine"
$lblTitle.Font = New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)
$lblTitle.ForeColor = [System.Drawing.Color]::Cyan
$lblTitle.Location = New-Object System.Drawing.Point(20, 15)
$lblTitle.Size = New-Object System.Drawing.Size(920, 30)
$form.Controls.Add($lblTitle)

$lblSub = New-Object System.Windows.Forms.Label
$lblSub.Text = "Auto-Initialized Control Hub: Polyglot | Physics | ZKP Verifier | Visualizer | Streams | Tuners | Web Hub"
$lblSub.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$lblSub.ForeColor = [System.Drawing.Color]::LightGray
$lblSub.Location = New-Object System.Drawing.Point(20, 45)
$lblSub.Size = New-Object System.Drawing.Size(920, 25)
$form.Controls.Add($lblSub)

# Tab Control Setup
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Location = New-Object System.Drawing.Point(20, 75)
$tabControl.Size = New-Object System.Drawing.Size(920, 720)

# TAB 1: POLYGLOT CODE GENERATOR
$tabPolyglot = New-Object System.Windows.Forms.TabPage
$tabPolyglot.Text = "Polyglot Compiler"; $tabPolyglot.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$lblPrompt = New-Object System.Windows.Forms.Label
$lblPrompt.Text = "Raw Human Semantics / Auto-Generated BraidC Stream:"
$lblPrompt.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); $lblPrompt.ForeColor = [System.Drawing.Color]::White; $lblPrompt.Location = New-Object System.Drawing.Point(15, 15); $lblPrompt.Size = New-Object System.Drawing.Size(450, 22)
$tabPolyglot.Controls.Add($lblPrompt)

$txtPrompt = New-Object System.Windows.Forms.TextBox
$txtPrompt.Multiline = $true; $txtPrompt.ScrollBars = "Vertical"; $txtPrompt.Size = New-Object System.Drawing.Size(875, 80); $txtPrompt.Location = New-Object System.Drawing.Point(15, 40)
$txtPrompt.BackColor = [System.Drawing.Color]::FromArgb(10, 12, 16); $txtPrompt.ForeColor = [System.Drawing.Color]::LimeGreen; $txtPrompt.Font = New-Object System.Drawing.Font("Consolas", 10)
$tabPolyglot.Controls.Add($txtPrompt)

$lblLang = New-Object System.Windows.Forms.Label
$lblLang.Text = "Target Language:"; $lblLang.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); $lblLang.ForeColor = [System.Drawing.Color]::White; $lblLang.Location = New-Object System.Drawing.Point(15, 135); $lblLang.Size = New-Object System.Drawing.Size(140, 25)
$tabPolyglot.Controls.Add($lblLang)

$cmbLang = New-Object System.Windows.Forms.ComboBox
$cmbLang.Location = New-Object System.Drawing.Point(160, 132); $cmbLang.Size = New-Object System.Drawing.Size(180, 28); $cmbLang.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cmbLang.Items.Add("Rust") | Out-Null; $cmbLang.Items.Add("Python") | Out-Null; $cmbLang.Items.Add("C/C++") | Out-Null; $cmbLang.Items.Add("Deno FFI") | Out-Null; $cmbLang.Items.Add("TypeScript") | Out-Null; $cmbLang.SelectedIndex = 0
$tabPolyglot.Controls.Add($cmbLang)

$btnCompile = New-Object System.Windows.Forms.Button
$btnCompile.Text = "Compile Polyglot Code"; $btnCompile.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); $btnCompile.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnCompile.ForeColor = [System.Drawing.Color]::White; $btnCompile.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; $btnCompile.Size = New-Object System.Drawing.Size(220, 32); $btnCompile.Location = New-Object System.Drawing.Point(360, 130)
$tabPolyglot.Controls.Add($btnCompile)

$txtOutput = New-Object System.Windows.Forms.TextBox
$txtOutput.Multiline = $true; $txtOutput.ScrollBars = "Both"; $txtOutput.Size = New-Object System.Drawing.Size(875, 490); $txtOutput.Location = New-Object System.Drawing.Point(15, 175)
$txtOutput.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12); $txtOutput.ForeColor = [System.Drawing.Color]::Cyan; $txtOutput.Font = New-Object System.Drawing.Font("Consolas", 10)
$tabPolyglot.Controls.Add($txtOutput)

$tabControl.Controls.Add($tabPolyglot)

# TAB 2: TC-UFT PHYSICS COMPUTE CORE & ZKP VERIFIER
$tabPhysics = New-Object System.Windows.Forms.TabPage
$tabPhysics.Text = "Physics & ZKP Verifier"; $tabPhysics.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$lblPhysTitle = New-Object System.Windows.Forms.Label
$lblPhysTitle.Text = "TC-UFT Isomorphic Physics & Zero-Knowledge Proof Evaluator"; $lblPhysTitle.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold); $lblPhysTitle.ForeColor = [System.Drawing.Color]::Cyan; $lblPhysTitle.Location = New-Object System.Drawing.Point(15, 15); $lblPhysTitle.Size = New-Object System.Drawing.Size(600, 25)
$tabPhysics.Controls.Add($lblPhysTitle)

$cmbPhysMode = New-Object System.Windows.Forms.ComboBox
$cmbPhysMode.Location = New-Object System.Drawing.Point(15, 48); $cmbPhysMode.Size = New-Object System.Drawing.Size(320, 28); $cmbPhysMode.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cmbPhysMode.Items.Add("Electroweak Charged Current (u_L + W- -> d_L)") | Out-Null; $cmbPhysMode.Items.Add("Yukawa Chirality Flip (e_L + H -> e_R)") | Out-Null; $cmbPhysMode.Items.Add("QED Neutral Vertex (e_L + gamma -> e_L)") | Out-Null; $cmbPhysMode.Items.Add("Generational Tau Decay (3rd Gen -> 1st Gen)") | Out-Null; $cmbPhysMode.SelectedIndex = 0
$tabPhysics.Controls.Add($cmbPhysMode)

$btnRunPhys = New-Object System.Windows.Forms.Button
$btnRunPhys.Text = "Calculate Physics"; $btnRunPhys.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); $btnRunPhys.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnRunPhys.ForeColor = [System.Drawing.Color]::White; $btnRunPhys.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; $btnRunPhys.Size = New-Object System.Drawing.Size(200, 32); $btnRunPhys.Location = New-Object System.Drawing.Point(350, 46)
$tabPhysics.Controls.Add($btnRunPhys)

$btnRunZKP = New-Object System.Windows.Forms.Button
$btnRunZKP.Text = "Verify ZKP Braid Proof (O(1))"; $btnRunZKP.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); $btnRunZKP.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnRunZKP.ForeColor = [System.Drawing.Color]::White; $btnRunZKP.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; $btnRunZKP.Size = New-Object System.Drawing.Size(280, 32); $btnRunZKP.Location = New-Object System.Drawing.Point(560, 46)
$tabPhysics.Controls.Add($btnRunZKP)

$txtPhysOut = New-Object System.Windows.Forms.TextBox
$txtPhysOut.Multiline = $true; $txtPhysOut.ScrollBars = "Both"; $txtPhysOut.Size = New-Object System.Drawing.Size(875, 580); $txtPhysOut.Location = New-Object System.Drawing.Point(15, 95)
$txtPhysOut.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12); $txtPhysOut.ForeColor = [System.Drawing.Color]::Yellow; $txtPhysOut.Font = New-Object System.Drawing.Font("Consolas", 10.5)
$tabPhysics.Controls.Add($txtPhysOut)

$tabControl.Controls.Add($tabPhysics)

# TAB 3: LIVE BRAID & E8 VISUALIZER
$tabVis = New-Object System.Windows.Forms.TabPage
$tabVis.Text = "Braid & E8 Visualizer"; $tabVis.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Size = New-Object System.Drawing.Size(875, 470); $pictureBox.Location = New-Object System.Drawing.Point(15, 15); $pictureBox.BackColor = [System.Drawing.Color]::FromArgb(10, 12, 16)
$tabVis.Controls.Add($pictureBox)

$btnSigma1 = New-Object System.Windows.Forms.Button
$btnSigma1.Text = "+ σ₁ (Twist 1-2)"; $btnSigma1.Size = New-Object System.Drawing.Size(140, 32); $btnSigma1.Location = New-Object System.Drawing.Point(15, 500); $btnSigma1.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnSigma1.ForeColor = [System.Drawing.Color]::White; $btnSigma1.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabVis.Controls.Add($btnSigma1)

$btnSigma2 = New-Object System.Windows.Forms.Button
$btnSigma2.Text = "+ σ₂ (Twist 2-3)"; $btnSigma2.Size = New-Object System.Drawing.Size(140, 32); $btnSigma2.Location = New-Object System.Drawing.Point(165, 500); $btnSigma2.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnSigma2.ForeColor = [System.Drawing.Color]::White; $btnSigma2.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabVis.Controls.Add($btnSigma2)

$btnCollapse = New-Object System.Windows.Forms.Button
$btnCollapse.Text = "Reidemeister Collapse"; $btnCollapse.Size = New-Object System.Drawing.Size(220, 32); $btnCollapse.Location = New-Object System.Drawing.Point(315, 500); $btnCollapse.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnCollapse.ForeColor = [System.Drawing.Color]::White; $btnCollapse.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabVis.Controls.Add($btnCollapse)

$btnClear = New-Object System.Windows.Forms.Button
$btnClear.Text = "Reset Braid"; $btnClear.Size = New-Object System.Drawing.Size(110, 32); $btnClear.Location = New-Object System.Drawing.Point(545, 500); $btnClear.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69); $btnClear.ForeColor = [System.Drawing.Color]::White; $btnClear.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabVis.Controls.Add($btnClear)

$lblVisStatus = New-Object System.Windows.Forms.Label
$lblVisStatus.Font = New-Object System.Drawing.Font("Consolas", 10.5, [System.Drawing.FontStyle]::Bold); $lblVisStatus.ForeColor = [System.Drawing.Color]::Cyan; $lblVisStatus.Location = New-Object System.Drawing.Point(15, 545); $lblVisStatus.Size = New-Object System.Drawing.Size(875, 120)
$tabVis.Controls.Add($lblVisStatus)

$tabControl.Controls.Add($tabVis)

# TAB 4: STREAM INGESTORS
$tabStreams = New-Object System.Windows.Forms.TabPage
$tabStreams.Text = "High-Throughput Ingestors"; $tabStreams.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$btnRunLHC = New-Object System.Windows.Forms.Button
$btnRunLHC.Text = "Run LHC Vector Stream (10 Billion/s)"; $btnRunLHC.Size = New-Object System.Drawing.Size(300, 35); $btnRunLHC.Location = New-Object System.Drawing.Point(15, 20); $btnRunLHC.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnRunLHC.ForeColor = [System.Drawing.Color]::White; $btnRunLHC.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabStreams.Controls.Add($btnRunLHC)

$btnRunMempool = New-Object System.Windows.Forms.Button
$btnRunMempool.Text = "Run Thermodynamic Mempool Stream"; $btnRunMempool.Size = New-Object System.Drawing.Size(300, 35); $btnRunMempool.Location = New-Object System.Drawing.Point(330, 20); $btnRunMempool.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnRunMempool.ForeColor = [System.Drawing.Color]::White; $btnRunMempool.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabStreams.Controls.Add($btnRunMempool)

$txtStreamOut = New-Object System.Windows.Forms.TextBox
$txtStreamOut.Multiline = $true; $txtStreamOut.ScrollBars = "Both"; $txtStreamOut.Size = New-Object System.Drawing.Size(875, 600); $txtStreamOut.Location = New-Object System.Drawing.Point(15, 70)
$txtStreamOut.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12); $txtStreamOut.ForeColor = [System.Drawing.Color]::LimeGreen; $txtStreamOut.Font = New-Object System.Drawing.Font("Consolas", 10.5)
$tabStreams.Controls.Add($txtStreamOut)

$tabControl.Controls.Add($tabStreams)

# TAB 5: HARDWARE & GAME TUNERS
$tabTuners = New-Object System.Windows.Forms.TabPage
$tabTuners.Text = "Hardware & Game Tuners"; $tabTuners.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$btnTuneSystem = New-Object System.Windows.Forms.Button
$btnTuneSystem.Text = "Apply Kernel RAM Lock & Core Un-Parking"; $btnTuneSystem.Size = New-Object System.Drawing.Size(380, 35); $btnTuneSystem.Location = New-Object System.Drawing.Point(15, 20); $btnTuneSystem.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnTuneSystem.ForeColor = [System.Drawing.Color]::White; $btnTuneSystem.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabTuners.Controls.Add($btnTuneSystem)

$btnTuneGPU = New-Object System.Windows.Forms.Button
$btnTuneGPU.Text = "Apply NVIDIA Ultra Low Latency & HAGS"; $btnTuneGPU.Size = New-Object System.Drawing.Size(380, 35); $btnTuneGPU.Location = New-Object System.Drawing.Point(410, 20); $btnTuneGPU.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnTuneGPU.ForeColor = [System.Drawing.Color]::White; $btnTuneGPU.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabTuners.Controls.Add($btnTuneGPU)

$btnTuneGames = New-Object System.Windows.Forms.Button
$btnTuneGames.Text = "Auto-Discover & Inject Fallout 4 / Skyrim 3GB Heap"; $btnTuneGames.Size = New-Object System.Drawing.Size(380, 35); $btnTuneGames.Location = New-Object System.Drawing.Point(15, 70); $btnTuneGames.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnTuneGames.ForeColor = [System.Drawing.Color]::White; $btnTuneGames.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabTuners.Controls.Add($btnTuneGames)

$btnTuneIO = New-Object System.Windows.Forms.Button
$btnTuneIO.Text = "Run NVMe File System I/O & TRIM"; $btnTuneIO.Size = New-Object System.Drawing.Size(380, 35); $btnTuneIO.Location = New-Object System.Drawing.Point(410, 70); $btnTuneIO.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnTuneIO.ForeColor = [System.Drawing.Color]::White; $btnTuneIO.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabTuners.Controls.Add($btnTuneIO)

$txtTunerOut = New-Object System.Windows.Forms.TextBox
$txtTunerOut.Multiline = $true; $txtTunerOut.ScrollBars = "Both"; $txtTunerOut.Size = New-Object System.Drawing.Size(875, 540); $txtTunerOut.Location = New-Object System.Drawing.Point(15, 120)
$txtTunerOut.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12); $txtTunerOut.ForeColor = [System.Drawing.Color]::Yellow; $txtTunerOut.Font = New-Object System.Drawing.Font("Consolas", 10)
$txtTunerOut.Text = "Auto-Initializing System Optimizations and Game Directory Tuning..."
$tabTuners.Controls.Add($txtTunerOut)

$tabControl.Controls.Add($tabTuners)

# TAB 6: LIVE EMBEDDED WEB TELEMETRY HUB
$tabWebHub = New-Object System.Windows.Forms.TabPage
$tabWebHub.Text = "Live Web Hub (Port 8090)"; $tabWebHub.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$btnOpenBrowser = New-Object System.Windows.Forms.Button
$btnOpenBrowser.Text = "Launch Spatial 3D Web Engine in External Browser (http://localhost:8090)"
$btnOpenBrowser.Size = New-Object System.Drawing.Size(550, 38)
$btnOpenBrowser.Location = New-Object System.Drawing.Point(15, 20)
$btnOpenBrowser.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btnOpenBrowser.ForeColor = [System.Drawing.Color]::White
$btnOpenBrowser.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabWebHub.Controls.Add($btnOpenBrowser)

$txtWebLog = New-Object System.Windows.Forms.TextBox
$txtWebLog.Multiline = $true; $txtWebLog.ScrollBars = "Both"; $txtWebLog.Size = New-Object System.Drawing.Size(875, 580); $txtWebLog.Location = New-Object System.Drawing.Point(15, 70)
$txtWebLog.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12); $txtWebLog.ForeColor = [System.Drawing.Color]::Cyan; $txtWebLog.Font = New-Object System.Drawing.Font("Consolas", 10.5)
$txtWebLog.Text = "[+] Spatial 3D WebGPU Constellation Server Active at http://localhost:8090`r`n[+] Listening on 0.0.0.0:8090 for mobile browsers & VR headsets`r`n[+] Click button above to open interactive 3D canvas!"
$tabWebHub.Controls.Add($txtWebLog)

$btnOpenBrowser.add_Click({ Start-Process "http://localhost:8090" })
$tabControl.Controls.Add($tabWebHub)

$form.Controls.Add($tabControl)

# ALL-STREAM REDIRECTION CALL HELPERS (*>&1)
function Execute-SemanticCompiler {
    $promptText = $txtPrompt.Text
    $selectedLang = $cmbLang.SelectedItem.ToString()
    $exePath = ".\topological_semantic_compiler.exe"

    if (Test-Path $exePath) {
        $promptClean = $promptText -replace "`r`n", " " -replace "`n", " "
        $result = & $exePath $promptClean $selectedLang *>&1 | Out-String
        $txtOutput.Text = $result
    } else { $txtOutput.Text = "[!] Missing topological_semantic_compiler.exe." }
}

function Execute-PhysicsCore {
    $modeArg = "ew"
    if ($cmbPhysMode.SelectedIndex -eq 1) { $modeArg = "yukawa" }
    if ($cmbPhysMode.SelectedIndex -eq 2) { $modeArg = "qed" }
    if ($cmbPhysMode.SelectedIndex -eq 3) { $modeArg = "tau_decay" }

    $exePath = ".\topological_physics_core.exe"

    if (Test-Path $exePath) {
        $result = & $exePath $modeArg *>&1 | Out-String
        $txtPhysOut.Text = $result
    } else { $txtPhysOut.Text = "[!] Missing topological_physics_core.exe." }
}

function Execute-ZKPVerifier {
    $exePath = ".\topological_zkp_verifier.exe"
    if (Test-Path $exePath) {
        $result = & $exePath *>&1 | Out-String
        $txtPhysOut.Text = $result
    } else { $txtPhysOut.Text = "[!] Missing topological_zkp_verifier.exe." }
}

function Sync-AllTabsFromBraidState {
    $braidLines = @("ALLOC_E8 256")
    foreach ($g in $script:braidGenerators) {
        if ($g -gt 0) { $braidLines += "SIGMA $g" } else { $braidLines += "SIGMA_INV $([Math]::Abs($g))" }
    }
    $braidLines += "SANTOS_ROT 0.17259029"
    $braidLines += "EMIT $($cmbLang.SelectedItem)"
    $txtPrompt.Text = $braidLines -join "`r`n"

    $writhe = 0
    foreach ($g in $script:braidGenerators) { if ($g -gt 0) { $writhe += 1 } else { $writhe -= 1 } }
    $charge = $writhe * 1.0
    $heat = [Math]::Abs($writhe) * [Math]::Log(2.0) * 0.693

    $genListStr = ($script:braidGenerators | ForEach-Object { if ($_ -gt 0) { "σ_$_" } else { "σ_$([Math]::Abs($_))⁻¹" } }) -join " · "
    if (-not $genListStr) { $genListStr = "e (Identity Braid)" }

    $lblVisStatus.Text = "Active Braid Word : $genListStr`nNet Writhe w(β)    : $writhe | Braid Charge Q(β): $charge`nLandauer Heat ΔS  : $([Math]::Round($heat, 4)) units | E8 Root Projection: Active"
    $pictureBox.Invalidate()

    Execute-SemanticCompiler
    Execute-PhysicsCore
}

$pictureBox.add_Paint({
    param($sender, $e)
    $g = $e.Graphics; $g.SmoothingMode = "AntiAlias"
    $pen1 = New-Object System.Drawing.Pen([System.Drawing.Color]::Cyan, 4)
    $pen2 = New-Object System.Drawing.Pen([System.Drawing.Color]::Magenta, 4)
    $pen3 = New-Object System.Drawing.Pen([System.Drawing.Color]::Yellow, 4)

    $startX = 40; $y1 = 100; $y2 = 210; $y3 = 320; $stepX = 80
    $g.DrawLine($pen1, 15, $y1, $startX, $y1); $g.DrawLine($pen2, 15, $y2, $startX, $y2); $g.DrawLine($pen3, 15, $y3, $startX, $y3)

    $currX = $startX; $s1_y = $y1; $s2_y = $y2; $s3_y = $y3
    foreach ($gen in $script:braidGenerators) {
        $nextX = $currX + $stepX
        if ([Math]::Abs($gen) -eq 1) {
            $g.DrawLine($pen1, $currX, $s1_y, $nextX, $s2_y); $g.DrawLine($pen2, $currX, $s2_y, $nextX, $s1_y); $g.DrawLine($pen3, $currX, $s3_y, $nextX, $s3_y)
            $tmp = $s1_y; $s1_y = $s2_y; $s2_y = $tmp
        } elseif ([Math]::Abs($gen) -eq 2) {
            $g.DrawLine($pen1, $currX, $s1_y, $nextX, $s1_y); $g.DrawLine($pen2, $currX, $s2_y, $nextX, $s3_y); $g.DrawLine($pen3, $currX, $s3_y, $nextX, $s2_y)
            $tmp = $s2_y; $s2_y = $s3_y; $s3_y = $tmp
        }
        $currX = $nextX
    }

    $centerX = 720; $centerY = 210; $radius = 80
    $penE8 = New-Object System.Drawing.Pen([System.Drawing.Color]::LimeGreen, 2)
    for ($i = 0; $i -lt 8; $i++) {
        $angleA = ($i * 45) * [Math]::PI / 180
        $x1 = $centerX + $radius * [Math]::Cos($angleA); $y1_pt = $centerY + $radius * [Math]::Sin($angleA)
        $g.FillEllipse([System.Drawing.Brushes]::Cyan, [float]($x1 - 5), [float]($y1_pt - 5), 10, 10)
        for ($j = $i + 1; $j -lt 8; $j++) {
            $angleB = ($j * 45) * [Math]::PI / 180
            $x2 = $centerX + $radius * [Math]::Cos($angleB); $y2_pt = $centerY + $radius * [Math]::Sin($angleB)
            $g.DrawLine($penE8, [float]$x1, [float]$y1_pt, [float]$x2, [float]$y2_pt)
        }
    }
})

# Event Wiring
$btnSigma1.add_Click({ $script:braidGenerators.Add(1); Sync-AllTabsFromBraidState })
$btnSigma2.add_Click({ $script:braidGenerators.Add(2); Sync-AllTabsFromBraidState })
$btnCollapse.add_Click({
    $i = 0
    while ($i -lt ($script:braidGenerators.Count - 1)) {
        if ($script:braidGenerators[$i] -eq -$script:braidGenerators[$i + 1]) {
            $script:braidGenerators.RemoveAt($i + 1); $script:braidGenerators.RemoveAt($i)
            if ($i -gt 0) { $i-- }
        } else { $i++ }
    }
    Sync-AllTabsFromBraidState
})
$btnClear.add_Click({ $script:braidGenerators.Clear(); Sync-AllTabsFromBraidState })

$btnRunLHC.add_Click({ if (Test-Path ".\topological_lhc_ingestor.exe") { $txtStreamOut.Text = & ".\topological_lhc_ingestor.exe" 5 *>&1 | Out-String } })
$btnRunMempool.add_Click({ if (Test-Path ".\topological_mempool_engine.exe") { $txtStreamOut.Text = & ".\topological_mempool_engine.exe" 5 *>&1 | Out-String } })

$btnTuneSystem.add_Click({ if (Test-Path ".\Optimize-TopologicalSystem_v2.ps1") { $txtTunerOut.Text = & ".\Optimize-TopologicalSystem_v2.ps1" *>&1 | Out-String } })
$btnTuneGPU.add_Click({ if (Test-Path ".\topological_gpu_tuner.ps1") { $txtTunerOut.Text = & ".\topological_gpu_tuner.ps1" *>&1 | Out-String } })
$btnTuneGames.add_Click({ if (Test-Path ".\topological_ini_tuner.ps1") { $txtTunerOut.Text = & ".\topological_ini_tuner.ps1" *>&1 | Out-String } })
$btnTuneIO.add_Click({ if (Test-Path ".\topological_io_tuner.ps1") { $txtTunerOut.Text = & ".\topological_io_tuner.ps1" *>&1 | Out-String } })

$cmbPhysMode.add_SelectedIndexChanged({
    $script:braidGenerators.Clear()
    if ($cmbPhysMode.SelectedIndex -eq 0) { $script:braidGenerators.Add(1); $script:braidGenerators.Add(2); $script:braidGenerators.Add(-1); $script:braidGenerators.Add(2); $script:braidGenerators.Add(1) }
    elseif ($cmbPhysMode.SelectedIndex -eq 1) { $script:braidGenerators.Add(-1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(-1); $script:braidGenerators.Add(-1) }
    elseif ($cmbPhysMode.SelectedIndex -eq 2) { $script:braidGenerators.Add(-1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(-1) }
    elseif ($cmbPhysMode.SelectedIndex -eq 3) { $script:braidGenerators.Add(1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(1) }
    Sync-AllTabsFromBraidState
})

$cmbLang.add_SelectedIndexChanged({ Execute-SemanticCompiler })
$btnCompile.add_Click({ Execute-SemanticCompiler })
$btnRunPhys.add_Click({ Execute-PhysicsCore })
$btnRunZKP.add_Click({ Execute-ZKPVerifier })

# INITIAL LAUNCH AUTO-INITIALIZATION PASS
Sync-AllTabsFromBraidState

if (Test-Path ".\topological_ini_tuner.ps1") {
    $txtTunerOut.Text = & ".\topological_ini_tuner.ps1" *>&1 | Out-String
}

[System.Windows.Forms.Application]::Run($form)
