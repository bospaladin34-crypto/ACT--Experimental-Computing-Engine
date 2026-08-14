[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ProjectPath,

    [string]$MainScriptName = "main.ps1",

    [switch]$GlobalPathImport
)

$actOmegaSource = "C:\sovereign_manifold\santos-sync\topological_system_optimizer"

if (-not (Test-Path $ProjectPath)) {
    Write-Host "[+] Creating target project directory: '$ProjectPath'..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $ProjectPath -Force | Out-Null
}

$moduleDestDir = Join-Path $ProjectPath "ACT_Omega"
if (-not (Test-Path $moduleDestDir)) {
    New-Item -ItemType Directory -Path $moduleDestDir -Force | Out-Null
}

Write-Host "[+] Copying ACT-Omega Module files to '$moduleDestDir'..." -ForegroundColor Green
Copy-Item -Path (Join-Path $actOmegaSource "ActOmega.psm1") -Destination $moduleDestDir -Force
Copy-Item -Path (Join-Path $actOmegaSource "ActOmega.psd1") -Destination $moduleDestDir -Force

$targetScriptPath = Join-Path $ProjectPath $MainScriptName

$importStatement = if ($GlobalPathImport) {
    "Import-Module `"$actOmegaSource\ActOmega.psd1`" -Force"
} else {
    "`$actOmegaModulePath = Join-Path `$PSScriptRoot `"ACT_Omega\ActOmega.psd1`"`r`nImport-Module `$actOmegaModulePath -Force"
}

$headerTemplate = @"
# ============================================================================
# ACT-Ω v25.0 Integrated PowerShell Script
# Target Project: $ProjectPath
# ============================================================================

$importStatement

Write-Host "[+] ACT-Omega v25.0 Integration Module Initialized!" -ForegroundColor Cyan

# Example 1: Synthesize Production Code
# `$queryResult = Invoke-ActOmegaQuery -Prompt "Make a fast memory buffer" -Language Python
# Write-Host `$queryResult.SynthesizedCode

# Example 2: Execute Kernel Memory Optimization & Protection
# Optimize-ActOmegaSystem
# Protect-ActOmegaMemory

# Example 3: Fire Event Cascade Intent
# Publish-ActOmegaEvent -IntentTag "INTENT_MEMORY_PRESSURE"
"@

if (Test-Path $targetScriptPath) {
    $existingContent = Get-Content -Path $targetScriptPath -Raw
    if ($existingContent -notmatch "Import-Module.*ActOmega") {
        Write-Host "[+] Injecting ACT-Omega module import into existing script: '$targetScriptPath'..." -ForegroundColor Yellow
        $newContent = "$headerTemplate`r`n`r`n# --- Original Script Content Below ---`r`n`r`n$existingContent"
        Set-Content -Path $targetScriptPath -Value $newContent -Encoding utf8
    } else {
        Write-Host "[!] Script '$targetScriptPath' already contains ACT-Omega import statement." -ForegroundColor Cyan
    }
} else {
    Write-Host "[+] Creating new main script '$targetScriptPath' with ACT-Omega integration..." -ForegroundColor Green
    Set-Content -Path $targetScriptPath -Value $headerTemplate -Encoding utf8
}

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [SUCCESS] ACT-Omega Module Injected into Project Successfully!" -ForegroundColor Green
Write-Host " Target Directory : $ProjectPath" -ForegroundColor Yellow
Write-Host " Script File      : $targetScriptPath" -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor DarkCyan
