# ============================================================================
# ACT-Ω Real-Time Dedicated Terminal FileWatcher & GitHub Auto-Push Daemon
# Continuous Live Output Console Logging All File Events & Git Statuses
# ============================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$scriptDir = "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
if (Test-Path $scriptDir) { Set-Location $scriptDir }

try {
    $Host.UI.RawUI.WindowTitle = "ACT-Ω Continuous GitHub Auto-Push Console"
} catch {}

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Live GitHub Auto-Sync Dedicated Terminal " -ForegroundColor Cyan
Write-Host " Target Repo: https://github.com/bospaladin34-crypto/ACT--Experimental-Computing-Engine.git" -ForegroundColor Gray
Write-Host "============================================================" -ForegroundColor DarkCyan

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $scriptDir
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

$global:lastPushTime = Get-Date

$action = {
    try {
        $now = Get-Date
        if (-not $global:lastPushTime -or ($now - $global:lastPushTime).TotalSeconds -gt 3) {
            $global:lastPushTime = $now
            
            $evtName = "Workspace File Update"
            if ($Event -and $Event.SourceEventArgs) {
                $evtName = "$($Event.SourceEventArgs.ChangeType) -> $($Event.SourceEventArgs.Name)"
            }

            Write-Host "`n[+] Event Triggered: $evtName" -ForegroundColor Yellow
            Write-Host " [+] Initiating GitHub Commit & Push Sequence..." -ForegroundColor Cyan

            if (Test-Path ".\git_auto_commit.ps1") {
                & ".\git_auto_commit.ps1"
            }
        }
    } catch {
        Write-Host "[!] Event Handler Notice: $_" -ForegroundColor Gray
    }
}

Register-ObjectEvent $watcher "Created" -Action $action | Out-Null
Register-ObjectEvent $watcher "Changed" -Action $action | Out-Null

Write-Host "`n[+] Dedicated Auto-Push Console Active and Listening..." -ForegroundColor Green
Write-Host "[+] All workspace file additions or edits will stream status here in real time." -ForegroundColor Gray

while ($true) {
    Start-Sleep -Seconds 5
}
