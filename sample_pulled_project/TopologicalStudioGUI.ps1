# ============================================================================
# ACT-Ω Unified Multi-Tab Bi-Directional Synchronized Studio GUI (Hardened)
# Integrates: Polyglot Generator + TC-UFT Physics Engine + Live Braid Visualizer
# ============================================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$scriptDir = "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
if (Test-Path $scriptDir) {
    Set-Location $scriptDir
}

$form = New-Object System.Windows.Forms.Form
$form.Text = "ACT-Ω v25.0 Unified Topological Studio (Live Synchronized)"
$form.Size = New-Object System.Drawing.Size(920, 800)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(24, 28, 36)
$form.ForeColor = [System.Drawing.Color]::White

$script:braidGenerators = [System.Collections.Generic.List[int]]::new()
$script:braidGenerators.Add(1)
$script:braidGenerators.Add(2)
$script:braidGenerators.Add(-2)
$script:braidGenerators.Add(1)

$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "ACT-Ω Unified Braid Polyglot, Physics & Live Visualizer Studio"
$lblTitle.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$lblTitle.ForeColor = [System.Drawing.Color]::Cyan
$lblTitle.Location = New-Object System.Drawing.Point(20, 15)
$lblTitle.Size = New-Object System.Drawing.Size(860, 30)
$form.Controls.Add($lblTitle)

$lblSub = New-Object System.Windows.Forms.Label
$lblSub.Text = "Bi-Directional Live Sync Active: Changes in Visualizer ↔ Physics Engine ↔ Polyglot Compiler"
$lblSub.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$lblSub.ForeColor = [System.Drawing.Color]::LightGray
$lblSub.Location = New-Object System.Drawing.Point(20, 45)
$lblSub.Size = New-Object System.Drawing.Size(860, 25)
$form.Controls.Add($lblSub)

$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Location = New-Object System.Drawing.Point(20, 75)
$tabControl.Size = New-Object System.Drawing.Size(860, 660)

# TAB 1: POLYGLOT CODE GENERATOR
$tabPolyglot = New-Object System.Windows.Forms.TabPage
$tabPolyglot.Text = "Polyglot Code Generator"
$tabPolyglot.BackColor = [System.Drawing.Color]::FromArgb(18, 22, 28)

$lblPrompt = New-Object System.Windows.Forms.Label
$lblPrompt.Text = "Raw Human Semantics / Auto-Generated BraidC Stream:"
$lblPrompt.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$lblPrompt.ForeColor = [System.Drawing.Color]::White
$lblPrompt.Location = New-Object System.Drawing.Point(15, 15)
$lblPrompt.Size = New-Object System.Drawing.Size(450, 22)
$tabPolyglot.Controls.Add($lblPrompt)

$txtPrompt = New-Object System.Windows.Forms.TextBox
$txtPrompt.Multiline = $true
$txtPrompt.ScrollBars = "Vertical"
$txtPrompt.Size = New-Object System.Drawing.Size(815, 80)
$txtPrompt.Location = New-Object System.Drawing.Point(15, 40)
$txtPrompt.BackColor = [System.Drawing.Color]::FromArgb(12, 14, 18)
$txtPrompt.ForeColor = [System.Drawing.Color]::LimeGreen
$txtPrompt.Font = New-Object System.Drawing.Font("Consolas", 10)
$tabPolyglot.Controls.Add($txtPrompt)

$lblLang = New-Object System.Windows.Forms.Label
$lblLang.Text = "Target Language:"
$lblLang.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$lblLang.ForeColor = [System.Drawing.Color]::White
$lblLang.Location = New-Object System.Drawing.Point(15, 135)
$lblLang.Size = New-Object System.Drawing.Size(140, 25)
$tabPolyglot.Controls.Add($lblLang)

$cmbLang = New-Object System.Windows.Forms.ComboBox
$cmbLang.Location = New-Object System.Drawing.Point(160, 132)
$cmbLang.Size = New-Object System.Drawing.Size(180, 28)
$cmbLang.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cmbLang.Items.Add("Rust") | Out-Null
$cmbLang.Items.Add("Python") | Out-Null
$cmbLang.Items.Add("C/C++") | Out-Null
$cmbLang.Items.Add("Deno FFI") | Out-Null
$cmbLang.Items.Add("TypeScript") | Out-Null
$cmbLang.SelectedIndex = 0
$tabPolyglot.Controls.Add($cmbLang)

$btnCompile = New-Object System.Windows.Forms.Button
$btnCompile.Text = "Compile & Wire Polyglot Code"
$btnCompile.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$btnCompile.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btnCompile.ForeColor = [System.Drawing.Color]::White
$btnCompile.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnCompile.Size = New-Object System.Drawing.Size(250, 32)
$btnCompile.Location = New-Object System.Drawing.Point(360, 130)
$tabPolyglot.Controls.Add($btnCompile)

$txtOutput = New-Object System.Windows.Forms.TextBox
$txtOutput.Multiline = $true
$txtOutput.ScrollBars = "Both"
$txtOutput.Size = New-Object System.Drawing.Size(815, 430)
$txtOutput.Location = New-Object System.Drawing.Point(15, 175)
$txtOutput.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12)
$txtOutput.ForeColor = [System.Drawing.Color]::Cyan
$txtOutput.Font = New-Object System.Drawing.Font("Consolas", 10)
$tabPolyglot.Controls.Add($txtOutput)

$tabControl.Controls.Add($tabPolyglot)

# TAB 2: TC-UFT PHYSICS COMPUTE CORE
$tabPhysics = New-Object System.Windows.Forms.TabPage
$tabPhysics.Text = "TC-UFT Physics Core (1:1 QFT/GR)"
$tabPhysics.BackColor = [System.Drawing.Color]::FromArgb(18, 22, 28)

$lblPhysTitle = New-Object System.Windows.Forms.Label
$lblPhysTitle.Text = "Topological Charge Unified Field Theory (TC-UFT) Vertex Evaluator"
$lblPhysTitle.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$lblPhysTitle.ForeColor = [System.Drawing.Color]::Cyan
$lblPhysTitle.Location = New-Object System.Drawing.Point(15, 15)
$lblPhysTitle.Size = New-Object System.Drawing.Size(600, 25)
$tabPhysics.Controls.Add($lblPhysTitle)

$lblMode = New-Object System.Windows.Forms.Label
$lblMode.Text = "Select Physics Process Preset:"
$lblMode.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$lblMode.ForeColor = [System.Drawing.Color]::White
$lblMode.Location = New-Object System.Drawing.Point(15, 50)
$lblMode.Size = New-Object System.Drawing.Size(220, 25)
$tabPhysics.Controls.Add($lblMode)

$cmbPhysMode = New-Object System.Windows.Forms.ComboBox
$cmbPhysMode.Location = New-Object System.Drawing.Point(240, 48)
$cmbPhysMode.Size = New-Object System.Drawing.Size(320, 28)
$cmbPhysMode.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cmbPhysMode.Items.Add("Electroweak Charged Current (u_L + W- -> d_L)") | Out-Null
$cmbPhysMode.Items.Add("Yukawa Chirality Flip (e_L + H -> e_R)") | Out-Null
$cmbPhysMode.Items.Add("QED Neutral Vertex (e_L + gamma -> e_L)") | Out-Null
$cmbPhysMode.Items.Add("Generational Tau Decay (3rd Gen -> 1st Gen)") | Out-Null
$cmbPhysMode.SelectedIndex = 0
$tabPhysics.Controls.Add($cmbPhysMode)

$btnRunPhys = New-Object System.Windows.Forms.Button
$btnRunPhys.Text = "Calculate Physics & Sheaf Coherence"
$btnRunPhys.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$btnRunPhys.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69)
$btnRunPhys.ForeColor = [System.Drawing.Color]::White
$btnRunPhys.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnRunPhys.Size = New-Object System.Drawing.Size(230, 32)
$btnRunPhys.Location = New-Object System.Drawing.Point(580, 46)
$tabPhysics.Controls.Add($btnRunPhys)

$txtPhysOut = New-Object System.Windows.Forms.TextBox
$txtPhysOut.Multiline = $true
$txtPhysOut.ScrollBars = "Both"
$txtPhysOut.Size = New-Object System.Drawing.Size(815, 520)
$txtPhysOut.Location = New-Object System.Drawing.Point(15, 95)
$txtPhysOut.BackColor = [System.Drawing.Color]::FromArgb(8, 10, 12)
$txtPhysOut.ForeColor = [System.Drawing.Color]::Yellow
$txtPhysOut.Font = New-Object System.Drawing.Font("Consolas", 10.5)
$tabPhysics.Controls.Add($txtPhysOut)

$tabControl.Controls.Add($tabPhysics)

# TAB 3: LIVE BRAID & E8 ROOT VISUALIZER
$tabVis = New-Object System.Windows.Forms.TabPage
$tabVis.Text = "Live Braid & E8 Visualizer"
$tabVis.BackColor = [System.Drawing.Color]::FromArgb(18, 22, 28)

$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Size = New-Object System.Drawing.Size(815, 420)
$pictureBox.Location = New-Object System.Drawing.Point(15, 15)
$pictureBox.BackColor = [System.Drawing.Color]::FromArgb(10, 12, 16)
$tabVis.Controls.Add($pictureBox)

$btnSigma1 = New-Object System.Windows.Forms.Button
$btnSigma1.Text = "+ σ₁ (Twist 1-2)"
$btnSigma1.Size = New-Object System.Drawing.Size(140, 32)
$btnSigma1.Location = New-Object System.Drawing.Point(15, 450)
$btnSigma1.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btnSigma1.ForeColor = [System.Drawing.Color]::White
$btnSigma1.FlatStyle = "Flat"
$tabVis.Controls.Add($btnSigma1)

$btnSigma2 = New-Object System.Windows.Forms.Button
$btnSigma2.Text = "+ σ₂ (Twist 2-3)"
$btnSigma2.Size = New-Object System.Drawing.Size(140, 32)
$btnSigma2.Location = New-Object System.Drawing.Point(165, 450)
$btnSigma2.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btnSigma2.ForeColor = [System.Drawing.Color]::White
$btnSigma2.FlatStyle = "Flat"
$tabVis.Controls.Add($btnSigma2)

$btnCollapse = New-Object System.Windows.Forms.Button
$btnCollapse.Text = "Reidemeister Collapse (σ_i · σ_i⁻¹ -> e)"
$btnCollapse.Size = New-Object System.Drawing.Size(260, 32)
$btnCollapse.Location = New-Object System.Drawing.Point(315, 450)
$btnCollapse.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69)
$btnCollapse.ForeColor = [System.Drawing.Color]::White
$btnCollapse.FlatStyle = "Flat"
$tabVis.Controls.Add($btnCollapse)

$btnClear = New-Object System.Windows.Forms.Button
$btnClear.Text = "Reset Braid"
$btnClear.Size = New-Object System.Drawing.Size(110, 32)
$btnClear.Location = New-Object System.Drawing.Point(585, 450)
$btnClear.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69)
$btnClear.ForeColor = [System.Drawing.Color]::White
$btnClear.FlatStyle = "Flat"
$tabVis.Controls.Add($btnClear)

$lblVisStatus = New-Object System.Windows.Forms.Label
$lblVisStatus.Font = New-Object System.Drawing.Font("Consolas", 10.5, [System.Drawing.FontStyle]::Bold)
$lblVisStatus.ForeColor = [System.Drawing.Color]::Cyan
$lblVisStatus.Location = New-Object System.Drawing.Point(15, 495)
$lblVisStatus.Size = New-Object System.Drawing.Size(815, 110)
$tabVis.Controls.Add($lblVisStatus)

$tabControl.Controls.Add($tabVis)
$form.Controls.Add($tabControl)

# DIRECT SYNCHRONOUS EXECUTION ENGINE HELPERS
function Execute-SemanticCompiler {
    $promptText = $txtPrompt.Text
    $selectedLang = $cmbLang.SelectedItem.ToString()
    $exePath = ".\topological_semantic_compiler.exe"

    if (Test-Path $exePath) {
        $promptClean = $promptText -replace "`r`n", " " -replace "`n", " "
        $result = & $exePath $promptClean $selectedLang 2>&1 | Out-String
        $txtOutput.Text = $result
    } else {
        $txtOutput.Text = "[!] Missing topological_semantic_compiler.exe."
    }
}

function Execute-PhysicsCore {
    $modeArg = "ew"
    if ($cmbPhysMode.SelectedIndex -eq 1) { $modeArg = "yukawa" }
    if ($cmbPhysMode.SelectedIndex -eq 2) { $modeArg = "qed" }
    if ($cmbPhysMode.SelectedIndex -eq 3) { $modeArg = "tau_decay" }

    $exePath = ".\topological_physics_core.exe"

    if (Test-Path $exePath) {
        $result = & $exePath $modeArg 2>&1 | Out-String
        $txtPhysOut.Text = $result
    } else {
        $txtPhysOut.Text = "[!] Missing topological_physics_core.exe."
    }
}

function Sync-AllTabsFromBraidState {
    $braidLines = @("ALLOC_E8 256")
    foreach ($g in $script:braidGenerators) {
        if ($g -gt 0) {
            $braidLines += "SIGMA $g"
        } else {
            $braidLines += "SIGMA_INV $([Math]::Abs($g))"
        }
    }
    $braidLines += "SANTOS_ROT 0.17259029"
    $braidLines += "EMIT $($cmbLang.SelectedItem)"
    $txtPrompt.Text = $braidLines -join "`r`n"

    $writhe = 0
    foreach ($g in $script:braidGenerators) {
        if ($g -gt 0) { $writhe += 1 } else { $writhe -= 1 }
    }
    $charge = $writhe * 1.0
    $heat = [Math]::Abs($writhe) * [Math]::Log(2.0) * 0.693

    $genListStr = ($script:braidGenerators | ForEach-Object { if ($_ -gt 0) { "σ_$_" } else { "σ_$([Math]::Abs($_))⁻¹" } }) -join " · "
    if (-not $genListStr) { $genListStr = "e (Identity Braid)" }

    $lblVisStatus.Text = "Active Braid Word : $genListStr`nNet Writhe w(β)    : $writhe | Braid Charge Q(β): $charge`nLandauer Heat ΔS  : $([Math]::Round($heat, 4)) units | E8 Root Projection: Active"
    $pictureBox.Invalidate()

    # Trigger Synchronous Updates Across Text Windows
    Execute-SemanticCompiler
    Execute-PhysicsCore
}

# Canvas Paint Handler
$pictureBox.add_Paint({
    param($sender, $e)
    $g = $e.Graphics
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    $penStrand1 = New-Object System.Drawing.Pen([System.Drawing.Color]::Cyan, 4)
    $penStrand2 = New-Object System.Drawing.Pen([System.Drawing.Color]::Magenta, 4)
    $penStrand3 = New-Object System.Drawing.Pen([System.Drawing.Color]::Yellow, 4)

    $startX = 40
    $y1 = 100; $y2 = 210; $y3 = 320
    $stepX = 80

    $g.DrawLine($penStrand1, 15, $y1, $startX, $y1)
    $g.DrawLine($penStrand2, 15, $y2, $startX, $y2)
    $g.DrawLine($penStrand3, 15, $y3, $startX, $y3)

    $currX = $startX
    $s1_y = $y1; $s2_y = $y2; $s3_y = $y3

    foreach ($gen in $script:braidGenerators) {
        $nextX = $currX + $stepX
        
        if ([Math]::Abs($gen) -eq 1) {
            $g.DrawLine($penStrand1, $currX, $s1_y, $nextX, $s2_y)
            $g.DrawLine($penStrand2, $currX, $s2_y, $nextX, $s1_y)
            $g.DrawLine($penStrand3, $currX, $s3_y, $nextX, $s3_y)
            $tmp = $s1_y; $s1_y = $s2_y; $s2_y = $tmp
        } elseif ([Math]::Abs($gen) -eq 2) {
            $g.DrawLine($penStrand1, $currX, $s1_y, $nextX, $s1_y)
            $g.DrawLine($penStrand2, $currX, $s2_y, $nextX, $s3_y)
            $g.DrawLine($penStrand3, $currX, $s3_y, $nextX, $s2_y)
            $tmp = $s2_y; $s2_y = $s3_y; $s3_y = $tmp
        }
        $currX = $nextX
    }

    # E8 Star Projection
    $centerX = 700; $centerY = 210; $radius = 80
    $penE8 = New-Object System.Drawing.Pen([System.Drawing.Color]::LimeGreen, 2)
    
    for ($i = 0; $i -lt 8; $i++) {
        $angleA = ($i * 45) * [Math]::PI / 180
        $x1 = $centerX + $radius * [Math]::Cos($angleA)
        $y1_pt = $centerY + $radius * [Math]::Sin($angleA)
        $g.FillEllipse([System.Drawing.Brushes]::Cyan, [float]($x1 - 5), [float]($y1_pt - 5), 10, 10)

        for ($j = $i + 1; $j -lt 8; $j++) {
            $angleB = ($j * 45) * [Math]::PI / 180
            $x2 = $centerX + $radius * [Math]::Cos($angleB)
            $y2_pt = $centerY + $radius * [Math]::Sin($angleB)
            $g.DrawLine($penE8, [float]$x1, [float]$y1_pt, [float]$x2, [float]$y2_pt)
        }
    }
})

# Event Wiring
$btnSigma1.add_Click({
    $script:braidGenerators.Add(1)
    Sync-AllTabsFromBraidState
})

$btnSigma2.add_Click({
    $script:braidGenerators.Add(2)
    Sync-AllTabsFromBraidState
})

$btnCollapse.add_Click({
    $i = 0
    while ($i -lt ($script:braidGenerators.Count - 1)) {
        if ($script:braidGenerators[$i] -eq -$script:braidGenerators[$i + 1]) {
            $script:braidGenerators.RemoveAt($i + 1)
            $script:braidGenerators.RemoveAt($i)
            if ($i -gt 0) { $i-- }
        } else {
            $i++
        }
    }
    Sync-AllTabsFromBraidState
})

$btnClear.add_Click({
    $script:braidGenerators.Clear()
    Sync-AllTabsFromBraidState
})

$cmbPhysMode.add_SelectedIndexChanged({
    $script:braidGenerators.Clear()
    if ($cmbPhysMode.SelectedIndex -eq 0) {
        $script:braidGenerators.Add(1); $script:braidGenerators.Add(2); $script:braidGenerators.Add(-1); $script:braidGenerators.Add(2); $script:braidGenerators.Add(1)
    } elseif ($cmbPhysMode.SelectedIndex -eq 1) {
        $script:braidGenerators.Add(-1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(-1); $script:braidGenerators.Add(-1)
    } elseif ($cmbPhysMode.SelectedIndex -eq 2) {
        $script:braidGenerators.Add(-1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(-1)
    } elseif ($cmbPhysMode.SelectedIndex -eq 3) {
        $script:braidGenerators.Add(1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(1); $script:braidGenerators.Add(1)
    }
    Sync-AllTabsFromBraidState
})

$cmbLang.add_SelectedIndexChanged({
    Execute-SemanticCompiler
})

$btnCompile.add_Click({
    Execute-SemanticCompiler
})

$btnRunPhys.add_Click({
    Execute-PhysicsCore
})

# Initial Sync
Sync-AllTabsFromBraidState

# Show Form
[System.Windows.Forms.Application]::Run($form)
