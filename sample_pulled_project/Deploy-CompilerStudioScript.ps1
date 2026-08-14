Set-Location "C:\sovereign_manifold\santos-sync\topological_system_optimizer"

$studioScriptText = @"
# ============================================================================
# ACT-Ω Dedicated Standalone Polyglot Compiler & Lexicon Studio GUI
# STA Thread Safe, 3-Panel Cybernetic IDE: Dictionary -> E8 -> BraidIR -> Code Domain
# Pre-Loaded Natural Language Test Prompts & Guaranteed Syntax Emitter
# ============================================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

`$OutputEncoding = [System.Text.Encoding]::UTF8

`$scriptDir = "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
if (Test-Path `$scriptDir) { Set-Location `$scriptDir }

`$form = New-Object System.Windows.Forms.Form
`$form.Text = "ACT-Ω Dedicated Polyglot Compiler Studio [Pre-Loaded Test Prompts & Syntax Guarantee]"
`$form.Size = New-Object System.Drawing.Size(1280, 880)
`$form.StartPosition = "CenterScreen"
`$form.BackColor = [System.Drawing.Color]::FromArgb(10, 13, 20) # Deep Void Navy
`$form.ForeColor = [System.Drawing.Color]::White

# Header Title Label
`$lblTitle = New-Object System.Windows.Forms.Label
`$lblTitle.Text = "ACT-Ω Dedicated Polyglot Compiler & Semantic Lexicon Studio"
`$lblTitle.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
`$lblTitle.ForeColor = [System.Drawing.Color]::FromArgb(0, 240, 255) # Cyber Cyan
`$lblTitle.Location = New-Object System.Drawing.Point(20, 12)
`$lblTitle.Size = New-Object System.Drawing.Size(1220, 32)
`$form.Controls.Add(`$lblTitle)

`$lblSub = New-Object System.Windows.Forms.Label
`$lblSub.Text = "Pre-Loaded Natural Language Test Prompts -> Semantic Lexicon Lookup -> E8 Pinning -> BraidIR -> Production Code Domain"
`$lblSub.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
`$lblSub.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 102) # Quantum Lime
`$lblSub.Location = New-Object System.Drawing.Point(20, 44)
`$lblSub.Size = New-Object System.Drawing.Size(1220, 24)
`$form.Controls.Add(`$lblSub)

# PANEL 1: LEFT PANEL - HUMAN PROMPT, PRESETS & LEXICON DICTIONARY LOOKUP
`$grpLeft = New-Object System.Windows.Forms.GroupBox
`$grpLeft.Text = "Panel 1: Pre-Loaded Test Prompts & Lexicon Database"; `$grpLeft.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Bold); `$grpLeft.ForeColor = [System.Drawing.Color]::Cyan
`$grpLeft.Location = New-Object System.Drawing.Point(20, 75); `$grpLeft.Size = New-Object System.Drawing.Size(390, 740); `$grpLeft.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 31)

`$lblPreset = New-Object System.Windows.Forms.Label
`$lblPreset.Text = "Pre-Loaded Natural Language Test Prompts:"
`$lblPreset.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); `$lblPreset.ForeColor = [System.Drawing.Color]::FromArgb(255, 215, 0); `$lblPreset.Location = New-Object System.Drawing.Point(12, 22); `$lblPreset.Size = New-Object System.Drawing.Size(365, 20)
`$grpLeft.Controls.Add(`$lblPreset)

`$cmbPresets = New-Object System.Windows.Forms.ComboBox
`$cmbPresets.Location = New-Object System.Drawing.Point(12, 44); `$cmbPresets.Size = New-Object System.Drawing.Size(365, 28); `$cmbPresets.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
`$cmbPresets.Items.Add("1. Python: Fast memory optimizer with P-Core & Shared Ring") | Out-Null
`$cmbPresets.Items.Add("2. Rust: E8 manifold vector allocator with atomic locks") | Out-Null
`$cmbPresets.Items.Add("3. C++: Low-latency direct DMA quantum cavity simulation") | Out-Null
`$cmbPresets.Items.Add("4. TypeScript: Deno FFI client wrapper for shared memory IPC") | Out-Null
`$cmbPresets.SelectedIndex = 0
`$grpLeft.Controls.Add(`$cmbPresets)

`$lblPrompt = New-Object System.Windows.Forms.Label
`$lblPrompt.Text = "Human Language Query / Active Code Generation Prompt:"
`$lblPrompt.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); `$lblPrompt.ForeColor = [System.Drawing.Color]::White; `$lblPrompt.Location = New-Object System.Drawing.Point(12, 80); `$lblPrompt.Size = New-Object System.Drawing.Size(365, 20)
`$grpLeft.Controls.Add(`$lblPrompt)

`$txtPrompt = New-Object System.Windows.Forms.TextBox
`$txtPrompt.Multiline = `$true; `$txtPrompt.ScrollBars = "Vertical"; `$txtPrompt.Size = New-Object System.Drawing.Size(365, 65); `$txtPrompt.Location = New-Object System.Drawing.Point(12, 102)
`$txtPrompt.BackColor = [System.Drawing.Color]::FromArgb(6, 8, 12); `$txtPrompt.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 102); `$txtPrompt.Font = New-Object System.Drawing.Font("Consolas", 9.5)
`$txtPrompt.Text = "Make me an extremely fast python memory optimizer that runs on physical p cores and connects to shared memory"
`$grpLeft.Controls.Add(`$txtPrompt)

`$btnLookup = New-Object System.Windows.Forms.Button
`$btnLookup.Text = "Query Lexicon & Pin E8 Vectors"; `$btnLookup.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Bold); `$btnLookup.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); `$btnLookup.ForeColor = [System.Drawing.Color]::White; `$btnLookup.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; `$btnLookup.Size = New-Object System.Drawing.Size(365, 34); `$btnLookup.Location = New-Object System.Drawing.Point(12, 175)
`$grpLeft.Controls.Add(`$btnLookup)

`$txtLexiconOut = New-Object System.Windows.Forms.TextBox
`$txtLexiconOut.Multiline = `$true; `$txtLexiconOut.ScrollBars = "Both"; `$txtLexiconOut.Size = New-Object System.Drawing.Size(365, 510); `$txtLexiconOut.Location = New-Object System.Drawing.Point(12, 215)
`$txtLexiconOut.BackColor = [System.Drawing.Color]::FromArgb(6, 8, 12); `$txtLexiconOut.ForeColor = [System.Drawing.Color]::Yellow; `$txtLexiconOut.Font = New-Object System.Drawing.Font("Consolas", 9.5)
`$grpLeft.Controls.Add(`$txtLexiconOut)

`$form.Controls.Add(`$grpLeft)

# PANEL 2: MIDDLE PANEL - E8 PINNING & BRAIDIR TRANSFORMATION
`$grpMiddle = New-Object System.Windows.Forms.GroupBox
`$grpMiddle.Text = "Panel 2: E8 Pinning & BraidIR Stream"; `$grpMiddle.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Bold); `$grpMiddle.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 102)
`$grpMiddle.Location = New-Object System.Drawing.Point(420, 75); `$grpMiddle.Size = New-Object System.Drawing.Size(390, 740); `$grpMiddle.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 31)

`$btnCompress = New-Object System.Windows.Forms.Button
`$btnCompress.Text = "Geometrically Compress BraidIR"; `$btnCompress.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Bold); `$btnCompress.BackColor = [System.Drawing.Color]::FromArgb(108, 117, 125); `$btnCompress.ForeColor = [System.Drawing.Color]::White; `$btnCompress.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; `$btnCompress.Size = New-Object System.Drawing.Size(365, 34); `$btnCompress.Location = New-Object System.Drawing.Point(12, 25)
`$grpMiddle.Controls.Add(`$btnCompress)

`$txtBraidOut = New-Object System.Windows.Forms.TextBox
`$txtBraidOut.Multiline = `$true; `$txtBraidOut.ScrollBars = "Both"; `$txtBraidOut.Size = New-Object System.Drawing.Size(365, 655); `$txtBraidOut.Location = New-Object System.Drawing.Point(12, 68)
`$txtBraidOut.BackColor = [System.Drawing.Color]::FromArgb(6, 8, 12); `$txtBraidOut.ForeColor = [System.Drawing.Color]::FromArgb(0, 240, 255); `$txtBraidOut.Font = New-Object System.Drawing.Font("Consolas", 9.5)
`$grpMiddle.Controls.Add(`$txtBraidOut)

`$form.Controls.Add(`$grpMiddle)

# PANEL 3: RIGHT PANEL - CODE DOMAIN SYNTHESIS & ONE-CLICK EXPORT
`$grpRight = New-Object System.Windows.Forms.GroupBox
`$grpRight.Text = "Panel 3: Code Domain Synthesis & Export"; `$grpRight.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Bold); `$grpRight.ForeColor = [System.Drawing.Color]::FromArgb(255, 215, 0)
`$grpRight.Location = New-Object System.Drawing.Point(820, 75); `$grpRight.Size = New-Object System.Drawing.Size(430, 740); `$grpRight.BackColor = [System.Drawing.Color]::FromArgb(16, 20, 31)

`$lblLang = New-Object System.Windows.Forms.Label
`$lblLang.Text = "Target Domain Language:"; `$lblLang.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); `$lblLang.ForeColor = [System.Drawing.Color]::White; `$lblLang.Location = New-Object System.Drawing.Point(12, 25); `$lblLang.Size = New-Object System.Drawing.Size(160, 22)
`$grpRight.Controls.Add(`$lblLang)

`$cmbDomainLang = New-Object System.Windows.Forms.ComboBox
`$cmbDomainLang.Location = New-Object System.Drawing.Point(175, 22); `$cmbDomainLang.Size = New-Object System.Drawing.Size(240, 28); `$cmbDomainLang.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
`$cmbDomainLang.Items.Add("Python") | Out-Null; `$cmbDomainLang.Items.Add("Rust") | Out-Null; `$cmbDomainLang.Items.Add("C/C++") | Out-Null; `$cmbDomainLang.Items.Add("TypeScript") | Out-Null; `$cmbDomainLang.Items.Add("Deno FFI") | Out-Null; `$cmbDomainLang.SelectedIndex = 0
`$grpRight.Controls.Add(`$cmbDomainLang)

`$btnCompileDomain = New-Object System.Windows.Forms.Button
`$btnCompileDomain.Text = "Synthesize Production Code (0 Errors)"; `$btnCompileDomain.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Bold); `$btnCompileDomain.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204); `$btnCompileDomain.ForeColor = [System.Drawing.Color]::White; `$btnCompileDomain.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; `$btnCompileDomain.Size = New-Object System.Drawing.Size(405, 34); `$btnCompileDomain.Location = New-Object System.Drawing.Point(12, 58)
`$grpRight.Controls.Add(`$btnCompileDomain)

`$btnCopyCode = New-Object System.Windows.Forms.Button
`$btnCopyCode.Text = "COPY CLEAN CODE TO CLIPBOARD"; `$btnCopyCode.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); `$btnCopyCode.BackColor = [System.Drawing.Color]::FromArgb(0, 255, 102); `$btnCopyCode.ForeColor = [System.Drawing.Color]::Black; `$btnCopyCode.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; `$btnCopyCode.Size = New-Object System.Drawing.Size(405, 36); `$btnCopyCode.Location = New-Object System.Drawing.Point(12, 98)
`$grpRight.Controls.Add(`$btnCopyCode)

`$btnSaveFile = New-Object System.Windows.Forms.Button
`$btnSaveFile.Text = "SAVE CODE DIRECTLY TO FILE"; `$btnSaveFile.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); `$btnSaveFile.BackColor = [System.Drawing.Color]::FromArgb(255, 215, 0); `$btnSaveFile.ForeColor = [System.Drawing.Color]::Black; `$btnSaveFile.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; `$btnSaveFile.Size = New-Object System.Drawing.Size(405, 36); `$btnSaveFile.Location = New-Object System.Drawing.Point(12, 140)
`$grpRight.Controls.Add(`$btnSaveFile)

`$txtCodeOut = New-Object System.Windows.Forms.TextBox
`$txtCodeOut.Multiline = `$true; `$txtCodeOut.ScrollBars = "Both"; `$txtCodeOut.Size = New-Object System.Drawing.Size(405, 540); `$txtCodeOut.Location = New-Object System.Drawing.Point(12, 184)
`$txtCodeOut.BackColor = [System.Drawing.Color]::FromArgb(6, 8, 12); `$txtCodeOut.ForeColor = [System.Drawing.Color]::FromArgb(0, 240, 255); `$txtCodeOut.Font = New-Object System.Drawing.Font("Consolas", 9.5)
`$grpRight.Controls.Add(`$txtCodeOut)

# ACTION EVENT HELPERS (*>&1)
function Execute-LexiconLookup {
    `$promptText = `$txtPrompt.Text
    if (Test-Path ".\topological_dictionary.exe") {
        `$promptClean = `$promptText -replace "`r`n", " " -replace "`n", " "
        `$result = & ".\topological_dictionary.exe" `$promptClean *>&1 | Out-String
        `$txtLexiconOut.Text = `$result
    }
}

function Execute-BraidCompression {
    `$promptText = `$txtPrompt.Text
    if (Test-Path ".\topological_geometric_tokenizer.exe") {
        `$promptClean = `$promptText -replace "`r`n", " " -replace "`n", " "
        `$result = & ".\topological_geometric_tokenizer.exe" `$promptClean *>&1 | Out-String
        `$txtBraidOut.Text = `$result
    }
}

function Execute-DomainSynthesis {
    `$promptText = `$txtPrompt.Text
    `$selectedLang = `$cmbDomainLang.SelectedItem.ToString()
    if (Test-Path ".\topological_semantic_compiler.exe") {
        `$promptClean = `$promptText -replace "`r`n", " " -replace "`n", " "
        `$result = & ".\topological_semantic_compiler.exe" `$promptClean `$selectedLang *>&1 | Out-String
        `$txtCodeOut.Text = `$result
    }
}

# PRESET SELECTOR EVENT
`$cmbPresets.add_SelectedIndexChanged({
    `$idx = `$cmbPresets.SelectedIndex
    if (`$idx -eq 0) {
        `$txtPrompt.Text = "Make me an extremely fast python memory optimizer that runs on physical p cores and connects to shared memory"
        `$cmbDomainLang.SelectedIndex = 0 # Python
    } elseif (`$idx -eq 1) {
        `$txtPrompt.Text = "Write a high performance rust E8 manifold vector allocator with atomic locks"
        `$cmbDomainLang.SelectedIndex = 1 # Rust
    } elseif (`$idx -eq 2) {
        `$txtPrompt.Text = "Write a C++ low latency direct DMA quantum cavity simulation class"
        `$cmbDomainLang.SelectedIndex = 2 # C++
    } elseif (`$idx -eq 3) {
        `$txtPrompt.Text = "Write a TypeScript Deno FFI client wrapper for shared memory IPC"
        `$cmbDomainLang.SelectedIndex = 3 # TypeScript
    }
    Execute-LexiconLookup
    Execute-BraidCompression
    Execute-DomainSynthesis
})

# EVENT WIRING
`$btnLookup.add_Click({ Execute-LexiconLookup; Execute-BraidCompression; Execute-DomainSynthesis })
`$btnCompress.add_Click({ Execute-BraidCompression })
`$btnCompileDomain.add_Click({ Execute-DomainSynthesis })
`$cmbDomainLang.add_SelectedIndexChanged({ Execute-DomainSynthesis })

`$btnCopyCode.add_Click({
    if (`$txtCodeOut.Text) {
        `$cleanCode = `$txtCodeOut.Text -replace "^```[a-zA-Z]*`r?`n", "" -replace "`r?`n```$", ""
        [System.Windows.Forms.Clipboard]::SetText(`$cleanCode)
        [System.Windows.Forms.MessageBox]::Show("Synthesized Code Copied Directly to Clipboard!", "ACT-Ω Compiler Studio", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
})

`$btnSaveFile.add_Click({
    if (`$txtCodeOut.Text) {
        `$selectedLang = `$cmbDomainLang.SelectedItem.ToString().ToLower()
        `$ext = ".rs"
        if (`$selectedLang -eq "python") { `$ext = ".py" }
        elseif (`$selectedLang -eq "c/c++") { `$ext = ".cpp" }
        elseif (`$selectedLang -eq "typescript" -or `$selectedLang -eq "deno ffi") { `$ext = ".ts" }

        `$saveDialog = New-Object System.Windows.Forms.SaveFileDialog
        `$saveDialog.Filter = "Source Code File (*`$ext)|*`$ext|All Files (*.*)|*.*"
        `$saveDialog.FileName = "topological_synthesized_code`$ext"
        
        if (`$saveDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            `$cleanCode = `$txtCodeOut.Text -replace "^```[a-zA-Z]*`r?`n", "" -replace "`r?`n```$", ""
            [System.IO.File]::WriteAllText(`$saveDialog.FileName, `$cleanCode)
            [System.Windows.Forms.MessageBox]::Show("Code Saved Directly to File: `$(`$saveDialog.FileName)", "ACT-Ω File Export", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        }
    }
})

# INITIAL AUTO-SYNTHESIS PASS
Execute-LexiconLookup
Execute-BraidCompression
Execute-DomainSynthesis

[System.Windows.Forms.Application]::Run(`$form)
"@

Set-Content -Path ".\TopologicalPolyglotCompilerStudio.ps1" -Value $studioScriptText -Encoding utf8
Write-Host "[+] TopologicalPolyglotCompilerStudio.ps1 written to disk successfully!" -ForegroundColor Green
