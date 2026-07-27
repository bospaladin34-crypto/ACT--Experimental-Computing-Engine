# ============================================================================
# ACT-Ω Automated Git Repository Commit & GitHub Sync Script
# Target Repository: https://github.com/bospaladin34-crypto/ACT--Experimental-Computing-Engine.git
# ============================================================================

param(
    [string]$RemoteUrl = "https://github.com/bospaladin34-crypto/ACT--Experimental-Computing-Engine.git"
)

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Set-Location "C:\sovereign_manifold\santos-sync\topological_system_optimizer"

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Continuous Git & GitHub Auto-Sync Engine " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor DarkCyan

if (-not (Test-Path ".git")) {
    Write-Host "[+] Initializing Local Git Repository..." -ForegroundColor Yellow
    git init | Out-Null
    git branch -M main 2>&1 | Out-Null
}

if ($RemoteUrl) {
    Write-Host "[+] Configuring Remote Repository Origin: $RemoteUrl" -ForegroundColor Green
    git remote remove origin 2>&1 | Out-Null
    git remote add origin "$RemoteUrl" 2>&1 | Out-Null
}

$timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMsg = "ACT-Omega Auto-Sync | Timestamp: $timeStamp | E8 State Latched"

Write-Host "[+] Staging All Workspace Files (git add .)..." -ForegroundColor Green
git add . 2>&1 | Out-Null

Write-Host "[+] Committing Workspace Changes: '$commitMsg'..." -ForegroundColor Green
git commit -m "$commitMsg" 2>&1 | Out-Null

Write-Host "[+] Pushing to Remote GitHub Repository (origin main)..." -ForegroundColor Green
git push -u origin main 2>&1 | Out-Null

Write-Host "`n============================================================" -ForegroundColor DarkCyan
Write-Host " [SUCCESS] Git Versioning & GitHub Continuous Sync Complete!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor DarkCyan
