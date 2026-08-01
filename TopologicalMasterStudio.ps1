# ============================================================================
# ACT-Ω Unified Master Topological Studio & Autonomous Control Center
# STA Thread Safe, Tab 7 Integrated Event Cascade & Autonomous Mesh Inspector
# ============================================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$OutputEncoding = [System.Text.Encoding]::UTF8

$scriptDir = "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
if (Test-Path $scriptDir) { Set-Location $scriptDir }

try { Stop-Process -Name "topological_web_hub" -Force -ErrorAction SilentlyContinue } catch {}

if (Test-Path ".\TopologicalHUD.ps1") {
    Start-Process powershell -ArgumentList "-sta -ExecutionPolicy Bypass -File .\TopologicalHUD.ps1" -WindowStyle Hidden
}

if (Test-Path ".\topological_web_hub.exe") {
    Start-Process -FilePath ".\topological_web_hub.exe" -WindowStyle Hidden
}

if (Test-Path ".\Start-TopologicalGitWatcher.ps1") {
    Start-Process powershell -ArgumentList "-NoExit -sta -ExecutionPolicy Bypass -File .\Start-TopologicalGitWatcher.ps1"
}

$form = New-Object System.Windows.Forms.Form
$form.Text = "ACT-Ω v25.0 Master Topological Control Center (7 Tabs Active | Event Cascade Inspector Enabled)"
$form.Size = New-Object System.Drawing.Size(1000, 920)
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
$lblTitle.Size = New-Object System.Drawing.Size(940, 30)
$form.Controls.Add($lblTitle)

$lblSub = New-Object System.Windows.Forms.Label
$lblSub.Text = "Autonomous Integrator & Event Cascade Active: Dynamic E8 Vector Matching (cos θ ≥ 0.85) & Hot-Registration"
$lblSub.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$lblSub.ForeColor = [System.Drawing.Color]::LightGray
$lblSub.Location = New-Object System.Drawing.Point(20, 45)
$lblSub.Size = New-Object System.Drawing.Size(940, 25)
$form.Controls.Add($lblSub)

# Tab Control Setup
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Location = New-Object System.Drawing.Point(20, 75)
$tabControl.Size = New-Object System.Drawing.Size(940, 780)

# TAB 1: POLYGLOT CODE GENERATOR & DEDICATED EXPORT ACTION ROW
$tabPolyglot = New-Object System.Windows.Forms.TabPage
$tabPolyglot.Text = "Polyglot Compiler & Export"; $tabPolyglot.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$lblPrompt = New-Object System.Windows.Forms.Label
$lblPrompt.Text = "Raw Human Semantics / Vague Language Prompt:"
$lblPrompt.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); $lblPrompt.ForeColor = [System.Drawing.Color]::White; $lblPrompt.Location = New-Object System.Drawing.Point(15, 12); $lblPrompt.Size = New-Object System.Drawing.Size(450, 22)
$tabPolyglot.Controls.Add($lblPrompt)

$txtPrompt = New-Object System.Windows.Forms.TextBox
$txtPrompt.Multiline = $true; $txtPrompt.ScrollBars = "Vertical"; $txtPrompt.Size = New-Object System.Drawing.Size(895, 65); $txtPrompt.Location = New-Object System.Drawing.Point(15, 35)
$txtPrompt.BackColor = [System.Drawing.Color]::FromArgb(10, 12, 16); $txtPrompt.ForeColor = [System.Drawing.Color]::LimeGreen; $txtPrompt.Font = New-Object System.Drawing.Font("Consolas", 10)
$txtPrompt.Text = "Make me an extremely fast python memory optimizer that runs on physical p cores and connects to shared memory"
$tabPolyglot.Controls.Add($txtPrompt)

# ROW 1: COMPILATION & TOKENIZER CONTROLS
$lblLang = New-Object System.Windows.Forms.Label
$lblLang.Text = "Language:"; $lblLang.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); $lblLang.ForeColor = [System.Drawing.Color]::White; $lblLang.Location = New-Object System.Drawing.Point(15, 112); $lblLang.Size = New-Object System.Drawing.Size(80, 25)
$tabPolyglot.Controls.Add($lblLang)

$cmbLang = New-Object System.Windows.Forms.ComboBox
$cmbLang.Location = New-Object System.Drawing.Point(95, 109); $cmbLang.Size = New-Object System.Drawing.Size(130, 28); $cmbLang.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cmbLang.Items.Add("Rust") | Out-Null; $cmbLang.Items.Add("Python") | Out-Null; $cmbLang.Items.Add("C/C++") | Out-Null; $cmbLang.Items.Add("Deno FFI") | Out-Null; $cmbLang.Items.Add("TypeScript") | Out-Null; $cmbLang.SelectedIndex = 1
$tabPolyglot.Controls.Add($cmbLang)

$btnCompile = New-Object System.Windows.Forms.Button
$btnCompile.Text = "Compile Polyglot Code"; $btnCompile.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Bold); $btnCompile.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnCompile.ForeColor = [System.Drawing.Color]::White; $btnCompile.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; $btnCompile.Size = New-Object System.Drawing.Size(220, 32); $btnCompile.Location = New-Object System.Drawing.Point(240, 107)
$tabPolyglot.Controls.Add($btnCompile)

$btnTokenize = New-Object System.Windows.Forms.Button
$btnTokenize.Text = "Geometrically Compress Prompt"; $btnTokenize.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Bold); $btnTokenize.BackColor = [System.Drawing.Color]::FromArgb(108, 117, 125); $btnTokenize.ForeColor = [System.Drawing.Color]::White; $btnTokenize.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; $btnTokenize.Size = New-Object System.Drawing.Size(260, 32); $btnTokenize.Location = New-Object System.Drawing.Point(470, 107)
$tabPolyglot.Controls.Add($btnTokenize)

# ROW 2: EXPORT BUTTONS
$btnCopyCode = New-Object System.Windows.Forms.Button
$btnCopyCode.Text = "COPY CODE TO CLIPBOARD"; $btnCopyCode.Font = New-Object System.Drawing.Font("Segoe UI", 10.5, [System.Drawing.FontStyle]::Bold); $btnCopyCode.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnCopyCode.ForeColor = [System.Drawing.Color]::White; $btnCopyCode.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; $btnCopyCode.Size = New-Object System.Drawing.Size(430, 38); $btnCopyCode.Location = New-Object System.Drawing.Point(15, 148)
$tabPolyglot.Controls.Add($btnCopyCode)

$btnSaveFile = New-Object System.Windows.Forms.Button
$btnSaveFile.Text = "SAVE CODE DIRECTLY TO FILE"; $btnSaveFile.Font = New-Object System.Drawing.Font("Segoe UI", 10.5, [System.Drawing.FontStyle]::Bold); $btnSaveFile.BackColor = [System.Drawing.Color]::FromArgb(255, 193, 7); $btnSaveFile.ForeColor = [System.Drawing.Color]::Black; $btnSaveFile.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; $btnSaveFile.Size = New-Object System.Drawing.Size(430, 38); $btnSaveFile.Location = New-Object System.Drawing.Point(460, 148)
$tabPolyglot.Controls.Add($btnSaveFile)

$txtOutput = New-Object System.Windows.Forms.TextBox
$txtOutput.Multiline = $true; $txtOutput.ScrollBars = "Both"; $txtOutput.Size = New-Object System.Drawing.Size(895, 500); $txtOutput.Location = New-Object System.Drawing.Point(15, 195)
$txtOutput.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12); $txtOutput.ForeColor = [System.Drawing.Color]::Cyan; $txtOutput.Font = New-Object System.Drawing.Font("Consolas", 10)
$tabPolyglot.Controls.Add($txtOutput)

$tabControl.Controls.Add($tabPolyglot)

# TAB 2: ADVANCED TOPOLOGICAL PHYSICS & QUANTUM ENGINE
$tabPhysics = New-Object System.Windows.Forms.TabPage
$tabPhysics.Text = "Physics & Quantum Core"; $tabPhysics.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$btnRunPhys = New-Object System.Windows.Forms.Button
$btnRunPhys.Text = "Run QFT/GR Core"; $btnRunPhys.Size = New-Object System.Drawing.Size(140, 32); $btnRunPhys.Location = New-Object System.Drawing.Point(15, 15); $btnRunPhys.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnRunPhys.ForeColor = "White"; $btnRunPhys.FlatStyle = "Flat"
$tabPhysics.Controls.Add($btnRunPhys)

$btnRunZKP = New-Object System.Windows.Forms.Button
$btnRunZKP.Text = "Verify ZKP Proof"; $btnRunZKP.Size = New-Object System.Drawing.Size(140, 32); $btnRunZKP.Location = New-Object System.Drawing.Point(165, 15); $btnRunZKP.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnRunZKP.ForeColor = "White"; $btnRunZKP.FlatStyle = "Flat"
$tabPhysics.Controls.Add($btnRunZKP)

$btnRunSheaf = New-Object System.Windows.Forms.Button
$btnRunSheaf.Text = "Sheaf Cohomology"; $btnRunSheaf.Size = New-Object System.Drawing.Size(140, 32); $btnRunSheaf.Location = New-Object System.Drawing.Point(315, 15); $btnRunSheaf.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnRunSheaf.ForeColor = "White"; $btnRunSheaf.FlatStyle = "Flat"
$tabPhysics.Controls.Add($btnRunSheaf)

$btnRunCasimir = New-Object System.Windows.Forms.Button
$btnRunCasimir.Text = "Casimir Pressure"; $btnRunCasimir.Size = New-Object System.Drawing.Size(140, 32); $btnRunCasimir.Location = New-Object System.Drawing.Point(465, 15); $btnRunCasimir.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnRunCasimir.ForeColor = "White"; $btnRunCasimir.FlatStyle = "Flat"
$tabPhysics.Controls.Add($btnRunCasimir)

$btnRunAnyon = New-Object System.Windows.Forms.Button
$btnRunAnyon.Text = "Anyon Fusion"; $btnRunAnyon.Size = New-Object System.Drawing.Size(120, 32); $btnRunAnyon.Location = New-Object System.Drawing.Point(615, 15); $btnRunAnyon.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69); $btnRunAnyon.ForeColor = "White"; $btnRunAnyon.FlatStyle = "Flat"
$tabPhysics.Controls.Add($btnRunAnyon)

$btnRunAttn = New-Object System.Windows.Forms.Button
$btnRunAttn.Text = "Braid Attention"; $btnRunAttn.Size = New-Object System.Drawing.Size(135, 32); $btnRunAttn.Location = New-Object System.Drawing.Point(745, 15); $btnRunAttn.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69); $btnRunAttn.ForeColor = "White"; $btnRunAttn.FlatStyle = "Flat"
$tabPhysics.Controls.Add($btnRunAttn)

$txtPhysOut = New-Object System.Windows.Forms.TextBox
$txtPhysOut.Multiline = $true; $txtPhysOut.ScrollBars = "Both"; $txtPhysOut.Size = New-Object System.Drawing.Size(895, 660); $txtPhysOut.Location = New-Object System.Drawing.Point(15, 60)
$txtPhysOut.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12); $txtPhysOut.ForeColor = [System.Drawing.Color]::Yellow; $txtPhysOut.Font = New-Object System.Drawing.Font("Consolas", 10.5)
$tabPhysics.Controls.Add($txtPhysOut)

$tabControl.Controls.Add($tabPhysics)

# TAB 3: LIVE BRAID & E8 VISUALIZER
$tabVis = New-Object System.Windows.Forms.TabPage
$tabVis.Text = "Braid & E8 Visualizer"; $tabVis.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Size = New-Object System.Drawing.Size(895, 500); $pictureBox.Location = New-Object System.Drawing.Point(15, 15); $pictureBox.BackColor = [System.Drawing.Color]::FromArgb(10, 12, 16)
$tabVis.Controls.Add($pictureBox)

$btnSigma1 = New-Object System.Windows.Forms.Button
$btnSigma1.Text = "+ σ₁ (Twist 1-2)"; $btnSigma1.Size = New-Object System.Drawing.Size(140, 32); $btnSigma1.Location = New-Object System.Drawing.Point(15, 530); $btnSigma1.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnSigma1.ForeColor = [System.Drawing.Color]::White; $btnSigma1.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabVis.Controls.Add($btnSigma1)

$btnSigma2 = New-Object System.Windows.Forms.Button
$btnSigma2.Text = "+ σ₂ (Twist 2-3)"; $btnSigma2.Size = New-Object System.Drawing.Size(140, 32); $btnSigma2.Location = New-Object System.Drawing.Point(165, 530); $btnSigma2.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnSigma2.ForeColor = [System.Drawing.Color]::White; $btnSigma2.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabVis.Controls.Add($btnSigma2)

$btnCollapse = New-Object System.Windows.Forms.Button
$btnCollapse.Text = "Reidemeister Collapse"; $btnCollapse.Size = New-Object System.Drawing.Size(220, 32); $btnCollapse.Location = New-Object System.Drawing.Point(315, 530); $btnCollapse.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnCollapse.ForeColor = [System.Drawing.Color]::White; $btnCollapse.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabVis.Controls.Add($btnCollapse)

$btnClear = New-Object System.Windows.Forms.Button
$btnClear.Text = "Reset Braid"; $btnClear.Size = New-Object System.Drawing.Size(110, 32); $btnClear.Location = New-Object System.Drawing.Point(545, 530); $btnClear.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69); $btnClear.ForeColor = [System.Drawing.Color]::White; $btnClear.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$tabVis.Controls.Add($btnClear)

$lblVisStatus = New-Object System.Windows.Forms.Label
$lblVisStatus.Font = New-Object System.Drawing.Font("Consolas", 10.5, [System.Drawing.FontStyle]::Bold); $lblVisStatus.ForeColor = [System.Drawing.Color]::Cyan; $lblVisStatus.Location = New-Object System.Drawing.Point(15, 575); $lblVisStatus.Size = New-Object System.Drawing.Size(895, 120)
$tabVis.Controls.Add($lblVisStatus)

$tabControl.Controls.Add($tabVis)

# TAB 4: STREAM INGESTORS
$tabStreams = New-Object System.Windows.Forms.TabPage
$tabStreams.Text = "High-Throughput Ingestors"; $tabStreams.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$btnRunLHC = New-Object System.Windows.Forms.Button
$btnRunLHC.Text = "Run LHC Vector Stream (10 Billion/s)"; $btnRunLHC.Size = New-Object System.Drawing.Size(300, 35); $btnRunLHC.Location = New-Object System.Drawing.Point(15, 20); $btnRunLHC.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnRunLHC.ForeColor = "White"; $btnRunLHC.FlatStyle = "Flat"
$tabStreams.Controls.Add($btnRunLHC)

$btnRunMempool = New-Object System.Windows.Forms.Button
$btnRunMempool.Text = "Run Thermodynamic Mempool Stream"; $btnRunMempool.Size = New-Object System.Drawing.Size(300, 35); $btnRunMempool.Location = New-Object System.Drawing.Point(330, 20); $btnRunMempool.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnRunMempool.ForeColor = "White"; $btnRunMempool.FlatStyle = "Flat"
$tabStreams.Controls.Add($btnRunMempool)

$txtStreamOut = New-Object System.Windows.Forms.TextBox
$txtStreamOut.Multiline = $true; $txtStreamOut.ScrollBars = "Both"; $txtStreamOut.Size = New-Object System.Drawing.Size(895, 640); $txtStreamOut.Location = New-Object System.Drawing.Point(15, 70)
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
$txtTunerOut.Multiline = $true; $txtTunerOut.ScrollBars = "Both"; $txtTunerOut.Size = New-Object System.Drawing.Size(895, 580); $txtTunerOut.Location = New-Object System.Drawing.Point(15, 120)
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
$txtWebLog.Multiline = $true; $txtWebLog.ScrollBars = "Both"; $txtWebLog.Size = New-Object System.Drawing.Size(895, 620); $txtWebLog.Location = New-Object System.Drawing.Point(15, 70)
$txtWebLog.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12); $txtWebLog.ForeColor = [System.Drawing.Color]::Cyan; $txtWebLog.Font = New-Object System.Drawing.Font("Consolas", 10.5)
$txtWebLog.Text = "[+] Spatial 3D WebGPU Constellation Server Active at http://localhost:8090`r`n[+] Listening on 0.0.0.0:8090 for mobile browsers & VR headsets`r`n[+] Click button above to open interactive 3D canvas!"
$tabWebHub.Controls.Add($txtWebLog)

$btnOpenBrowser.add_Click({ Start-Process "http://localhost:8090" })
$tabControl.Controls.Add($tabWebHub)

# TAB 7: AUTONOMOUS INTEGRATOR & EVENT CASCADE MESH INSPECTOR
$tabCascade = New-Object System.Windows.Forms.TabPage
$tabCascade.Text = "Event Cascade & Mesh Inspector"; $tabCascade.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 26)

$btnRunIntegrator = New-Object System.Windows.Forms.Button
$btnRunIntegrator.Text = "Run Autonomous Integrator Pass"; $btnRunIntegrator.Size = New-Object System.Drawing.Size(260, 35); $btnRunIntegrator.Location = New-Object System.Drawing.Point(15, 18); $btnRunIntegrator.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); $btnRunIntegrator.ForeColor = "White"; $btnRunIntegrator.FlatStyle = "Flat"
$tabCascade.Controls.Add($btnRunIntegrator)

$btnRunCascade = New-Object System.Windows.Forms.Button
$btnRunCascade.Text = "Fire Event Cascade Engine"; $btnRunCascade.Size = New-Object System.Drawing.Size(220, 35); $btnRunCascade.Location = New-Object System.Drawing.Point(285, 18); $btnRunCascade.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69); $btnRunCascade.ForeColor = "White"; $btnRunCascade.FlatStyle = "Flat"
$tabCascade.Controls.Add($btnRunCascade)

$btnRunRegistry = New-Object System.Windows.Forms.Button
$btnRunRegistry.Text = "Scan Dynamic Module Registry"; $btnRunRegistry.Size = New-Object System.Drawing.Size(220, 35); $btnRunRegistry.Location = New-Object System.Drawing.Point(515, 18); $btnRunRegistry.BackColor = [System.Drawing.Color]::FromArgb(255, 193, 7); $btnRunRegistry.ForeColor = "Black"; $btnRunRegistry.FlatStyle = "Flat"
$tabCascade.Controls.Add($btnRunRegistry)

$btnRunSwarm = New-Object System.Windows.Forms.Button
$btnRunSwarm.Text = "Ping Swarm Mesh"; $btnRunSwarm.Size = New-Object System.Drawing.Size(160, 35); $btnRunSwarm.Location = New-Object System.Drawing.Point(745, 18); $btnRunSwarm.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69); $btnRunSwarm.ForeColor = "White"; $btnRunSwarm.FlatStyle = "Flat"
$tabCascade.Controls.Add($btnRunSwarm)

$txtCascadeOut = New-Object System.Windows.Forms.TextBox
$txtCascadeOut.Multiline = $true; $txtCascadeOut.ScrollBars = "Both"; $txtCascadeOut.Size = New-Object System.Drawing.Size(895, 640); $txtCascadeOut.Location = New-Object System.Drawing.Point(15, 65)
$txtCascadeOut.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12); $txtCascadeOut.ForeColor = [System.Drawing.Color]::LimeGreen; $txtCascadeOut.Font = New-Object System.Drawing.Font("Consolas", 10.5)
$txtCascadeOut.Text = "[+] Dynamic Topological Event Cascade Engine Active.`r`n[+] Click buttons above to execute autonomous integration passes, scan module capability maps, or ping local network swarm mesh nodes."
$tabCascade.Controls.Add($txtCascadeOut)

$btnRunIntegrator.add_Click({ if (Test-Path ".\topological_autonomous_integrator.exe") { $txtCascadeOut.Text = & ".\topological_autonomous_integrator.exe" *>&1 | Out-String } })
$btnRunCascade.add_Click({ if (Test-Path ".\topological_event_cascade.exe") { $txtCascadeOut.Text = & ".\topological_event_cascade.exe" "INTENT_MEMORY_PRESSURE" *>&1 | Out-String } })
$btnRunRegistry.add_Click({ if (Test-Path ".\topological_module_registry.exe") { $txtCascadeOut.Text = & ".\topological_module_registry.exe" *>&1 | Out-String } })
$btnRunSwarm.add_Click({ if (Test-Path ".\topological_cluster_mesh.exe") { $txtCascadeOut.Text = & ".\topological_cluster_mesh.exe" *>&1 | Out-String } })

$tabControl.Controls.Add($tabCascade)

$form.Controls.Add($tabControl)

# ALL-STREAM REDIRECTION CALL HELPERS (*>&1)
function Execute-GeometricTokenizer {
    $promptText = $txtPrompt.Text
    $exePath = ".\topological_geometric_tokenizer.exe"

    if (Test-Path $exePath) {
        $promptClean = $promptText -replace "`r`n", " " -replace "`n", " "
        $result = & $exePath $promptClean *>&1 | Out-String
        $txtOutput.Text = $result
    } else {
        Execute-SemanticCompiler
    }
}

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
    if (Test-Path ".\topological_physics_core.exe") {
        $txtPhysOut.Text = & ".\topological_physics_core.exe" "ew" *>&1 | Out-String
    }
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

# TAB 1 ONE-CLICK CLIPBOARD COPY HANDLER
$btnCopyCode.add_Click({
    if ($txtOutput.Text) {
        $cleanCode = $txtOutput.Text -replace "^```[a-zA-Z]*`r?`n", "" -replace "`r?`n```$", ""
        [System.Windows.Forms.Clipboard]::SetText($cleanCode)
        [System.Windows.Forms.MessageBox]::Show("Compiled Code Copied Directly to Clipboard!", "ACT-Ω Code Export", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
})

# TAB 1 ONE-CLICK DIRECT FILE EXPORT HANDLER
$btnSaveFile.add_Click({
    if ($txtOutput.Text) {
        $selectedLang = $cmbLang.SelectedItem.ToString().ToLower()
        $ext = ".rs"
        if ($selectedLang -eq "python") { $ext = ".py" }
        elseif ($selectedLang -eq "c/c++" -or $selectedLang -eq "c++") { $ext = ".cpp" }
        elseif ($selectedLang -eq "typescript" -or $selectedLang -eq "deno ffi") { $ext = ".ts" }

        $saveDialog = New-Object System.Windows.Forms.SaveFileDialog
        $saveDialog.Filter = "Source Code File (*$ext)|*$ext|All Files (*.*)|*.*"
        $saveDialog.FileName = "topological_generated_code$ext"
        
        if ($saveDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            $cleanCode = $txtOutput.Text -replace "^```[a-zA-Z]*`r?`n", "" -replace "`r?`n```$", ""
            [System.IO.File]::WriteAllText($saveDialog.FileName, $cleanCode)
            [System.Windows.Forms.MessageBox]::Show("Code Saved Directly to File: $($saveDialog.FileName)", "ACT-Ω File Export", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        }
    }
})

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

    $centerX = 740; $centerY = 210; $radius = 80
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

# Physics Tab Extra Button Actions
$btnRunPhys.add_Click({ Execute-PhysicsCore })
$btnRunZKP.add_Click({ if (Test-Path ".\topological_zkp_verifier.exe") { $txtPhysOut.Text = & ".\topological_zkp_verifier.exe" *>&1 | Out-String } })
$btnRunSheaf.add_Click({ if (Test-Path ".\topological_sheaf_cohomology.exe") { $txtPhysOut.Text = & ".\topological_sheaf_cohomology.exe" *>&1 | Out-String } })
$btnRunCasimir.add_Click({ if (Test-Path ".\topological_casimir_force.exe") { $txtPhysOut.Text = & ".\topological_casimir_force.exe" *>&1 | Out-String } })
$btnRunAnyon.add_Click({ if (Test-Path ".\topological_anyon_braid.exe") { $txtPhysOut.Text = & ".\topological_anyon_braid.exe" *>&1 | Out-String } })
$btnRunAttn.add_Click({ if (Test-Path ".\topological_braid_attention.exe") { $txtPhysOut.Text = & ".\topological_braid_attention.exe" *>&1 | Out-String } })

$cmbLang.add_SelectedIndexChanged({ Execute-SemanticCompiler })
$btnCompile.add_Click({ Execute-SemanticCompiler })
$btnTokenize.add_Click({ Execute-GeometricTokenizer })

# INITIAL LAUNCH AUTO-INITIALIZATION PASS
Sync-AllTabsFromBraidState

if (Test-Path ".\topological_ini_tuner.ps1") {
    $txtTunerOut.Text = & ".\topological_ini_tuner.ps1" *>&1 | Out-String
}

[System.Windows.Forms.Application]::Run($form)
