# ============================================================================
# ACT-Ω Automated Git Repository Commit & GitHub Sync Script
# Clean Native Exit Code Handling & Suppresses False PowerShell Stderr Errors
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
    git init
    git branch -M main
}

if ($RemoteUrl) {
    git remote remove origin 2>$null
    git remote add origin "$RemoteUrl" 2>$null
}

$timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMsg = "ACT-Omega Auto-Sync | Timestamp: $timeStamp | E8 State Latched"

Write-Host "[+] Staging All Files..." -ForegroundColor Green
git add .

Write-Host "[+] Creating Commit: '$commitMsg'..." -ForegroundColor Green
git commit -m "$commitMsg" 2>$null

Write-Host "[+] Syncing & Pushing Local Commits to GitHub (origin main)..." -ForegroundColor Green
git push -u origin main 2>$null

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n============================================================" -ForegroundColor DarkCyan
    Write-Host " [SUCCESS] All Workspace Files Successfully Synced to GitHub!" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor DarkCyan
} else {
    Write-Host "`n[!] Notice: Git push exited with code $LASTEXITCODE. Retrying with pull rebase..." -ForegroundColor Yellow
    git pull origin main --rebase 2>$null
    git push -u origin main 2>$null
}
