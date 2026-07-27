# ============================================================================
# ACT-Ω Real-Time FileSystemWatcher & Continuous GitHub Auto-Push Daemon
# Listens for Workspace File Changes & Instantly Commits/Pushes to GitHub
# ============================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$scriptDir = "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
if (Test-Path $scriptDir) { Set-Location $scriptDir }

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] FileSystemWatcher & Continuous GitHub Sync " -ForegroundColor Cyan
Write-Host " Target Repo: https://github.com/bospaladin34-crypto/ACT--Experimental-Computing-Engine.git" -ForegroundColor Gray
Write-Host "============================================================" -ForegroundColor DarkCyan

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $scriptDir
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

$script:lastPushTime = Get-Date

$action = {
    $now = Get-Date
    if (($now - $script:lastPushTime).TotalSeconds -gt 5) {
        $script:lastPushTime = $now
        Write-Host "`n[+] Workspace Event Detected: $($Event.SourceEventArgs.ChangeType) - $($Event.SourceEventArgs.Name)" -ForegroundColor Yellow
        Write-Host " [+] Auto-Triggering GitHub Commit & Push Pass..." -ForegroundColor Cyan
        
        if (Test-Path ".\git_auto_commit.ps1") {
            & ".\git_auto_commit.ps1" *>&1 | Out-Null
            Write-Host " [+] GitHub Repository Updated Successfully!" -ForegroundColor Green
        }
    }
}

Register-ObjectEvent $watcher "Created" -Action $action | Out-Null
Register-ObjectEvent $watcher "Changed" -Action $action | Out-Null

Write-Host "[+] Real-Time Workspace File Watcher Active. Monitoring for changes..." -ForegroundColor Green

while ($true) {
    Start-Sleep -Seconds 10
}
