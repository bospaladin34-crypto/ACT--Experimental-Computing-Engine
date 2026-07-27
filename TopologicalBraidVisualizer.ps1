# ============================================================================
# ACT-Ω Live Braid Motif & E8 Root Visualizer
# Framework: System.Drawing / WinForms Interactive Topology Canvas
# ============================================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$form = New-Object System.Windows.Forms.Form
$form.Text = "ACT-Ω v25.0 Live Braid Motif & E8 Root Visualizer"
$form.Size = New-Object System.Drawing.Size(900, 720)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(20, 24, 32)
$form.ForeColor = [System.Drawing.Color]::White

$script:braidGenerators = [System.Collections.Generic.List[int]]::new()
$script:braidGenerators.Add(1)
$script:braidGenerators.Add(2)
$script:braidGenerators.Add(-2)
$script:braidGenerators.Add(1)

$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Size = New-Object System.Drawing.Size(840, 480)
$pictureBox.Location = New-Object System.Drawing.Point(20, 20)
$pictureBox.BackColor = [System.Drawing.Color]::FromArgb(10, 12, 16)
$form.Controls.Add($pictureBox)

$btnSigma1 = New-Object System.Windows.Forms.Button
$btnSigma1.Text = "+ σ₁ (Twist 1-2)"
$btnSigma1.Size = New-Object System.Drawing.Size(150, 35)
$btnSigma1.Location = New-Object System.Drawing.Point(20, 520)
$btnSigma1.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btnSigma1.ForeColor = [System.Drawing.Color]::White
$btnSigma1.FlatStyle = "Flat"
$form.Controls.Add($btnSigma1)

$btnSigma2 = New-Object System.Windows.Forms.Button
$btnSigma2.Text = "+ σ₂ (Twist 2-3)"
$btnSigma2.Size = New-Object System.Drawing.Size(150, 35)
$btnSigma2.Location = New-Object System.Drawing.Point(180, 520)
$btnSigma2.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btnSigma2.ForeColor = [System.Drawing.Color]::White
$btnSigma2.FlatStyle = "Flat"
$form.Controls.Add($btnSigma2)

$btnCollapse = New-Object System.Windows.Forms.Button
$btnCollapse.Text = "Reidemeister Collapse (σ_i · σ_i⁻¹ -> e)"
$btnCollapse.Size = New-Object System.Drawing.Size(280, 35)
$btnCollapse.Location = New-Object System.Drawing.Point(340, 520)
$btnCollapse.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69)
$btnCollapse.ForeColor = [System.Drawing.Color]::White
$btnCollapse.FlatStyle = "Flat"
$form.Controls.Add($btnCollapse)

$btnClear = New-Object System.Windows.Forms.Button
$btnClear.Text = "Reset Braid"
$btnClear.Size = New-Object System.Drawing.Size(120, 35)
$btnClear.Location = New-Object System.Drawing.Point(630, 520)
$btnClear.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69)
$btnClear.ForeColor = [System.Drawing.Color]::White
$btnClear.FlatStyle = "Flat"
$form.Controls.Add($btnClear)

$lblStatus = New-Object System.Windows.Forms.Label
$lblStatus.Font = New-Object System.Drawing.Font("Consolas", 11, [System.Drawing.FontStyle]::Bold)
$lblStatus.ForeColor = [System.Drawing.Color]::Cyan
$lblStatus.Location = New-Object System.Drawing.Point(20, 575)
$lblStatus.Size = New-Object System.Drawing.Size(840, 80)
$form.Controls.Add($lblStatus)

$pictureBox.add_Paint({
    param($sender, $e)
    $g = $e.Graphics
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    $penStrand1 = New-Object System.Drawing.Pen([System.Drawing.Color]::Cyan, 4)
    $penStrand2 = New-Object System.Drawing.Pen([System.Drawing.Color]::Magenta, 4)
    $penStrand3 = New-Object System.Drawing.Pen([System.Drawing.Color]::Yellow, 4)

    $startX = 50
    $y1 = 120; $y2 = 240; $y3 = 360
    $stepX = 90

    $g.DrawLine($penStrand1, 20, $y1, $startX, $y1)
    $g.DrawLine($penStrand2, 20, $y2, $startX, $y2)
    $g.DrawLine($penStrand3, 20, $y3, $startX, $y3)

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

    $centerX = 720; $centerY = 240; $radius = 90
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

function Update-TopologyMetrics {
    $writhe = 0
    foreach ($g in $script:braidGenerators) {
        if ($g -gt 0) { $writhe += 1 } else { $writhe -= 1 }
    }
    $charge = $writhe * 1.0
    $heat = [Math]::Abs($writhe) * [Math]::Log(2.0) * 0.693

    $genListStr = ($script:braidGenerators | ForEach-Object { if ($_ -gt 0) { "σ_$_" } else { "σ_$([Math]::Abs($_))⁻¹" } }) -join " · "
    if (-not $genListStr) { $genListStr = "e (Identity Braid)" }

    $lblStatus.Text = "Active Braid Word : $genListStr`nNet Writhe w(β)    : $writhe | Braid Charge Q(β): $charge`nLandauer Heat ΔS  : $([Math]::Round($heat, 4)) units | E8 Root Projection: Active"
    $pictureBox.Invalidate()
}

$btnSigma1.add_Click({
    $script:braidGenerators.Add(1)
    Update-TopologyMetrics
})

$btnSigma2.add_Click({
    $script:braidGenerators.Add(2)
    Update-TopologyMetrics
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
    Update-TopologyMetrics
})

$btnClear.add_Click({
    $script:braidGenerators.Clear()
    Update-TopologyMetrics
})

Update-TopologyMetrics
[System.Windows.Forms.Application]::Run($form)
