# ============================================================================
# ACT-Ω v25.0 Unified One-Click Autopoietic Engine & Control Center Launcher
# Unifies All 45 Native Rust Subsystems, Continuous Daemon, Git Watcher & Studio GUI
# ============================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[!] Elevating process permissions to Administrator..." -ForegroundColor Yellow
    $scriptPath = $MyInvocation.MyCommand.Definition
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    exit
}

Set-Location "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Launching Autopoietic Self-Maintaining Platform " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor DarkCyan

try { Stop-Process -Name "TopologicalMasterStudio" -Force -ErrorAction SilentlyContinue } catch {}
try { Stop-Process -Name "act_omega_autopoietic_daemon" -Force -ErrorAction SilentlyContinue } catch {}

if (Test-Path ".\Build-MasterEXE.ps1") {
    Write-Host "[1/3] Building Standalone Master Executable (TopologicalMasterStudio.exe)..." -ForegroundColor Yellow
    & ".\Build-MasterEXE.ps1"
}

if (Test-Path ".\act_omega_autopoietic_daemon.rs") {
    if (-not (Test-Path ".\act_omega_autopoietic_daemon.exe")) {
        rustc -O act_omega_autopoietic_daemon.rs -o act_omega_autopoietic_daemon.exe
    }
    Write-Host "[2/3] Spawning Autopoietic Background Daemon (15.965 Hz Cadence Lock)..." -ForegroundColor Green
    Start-Process -FilePath ".\act_omega_autopoietic_daemon.exe" -WindowStyle Hidden
}

if (Test-Path ".\Start-TopologicalGitWatcher.ps1") {
    Write-Host "[3/3] Activating Continuous GitHub Auto-Push Watcher..." -ForegroundColor Green
    Start-Process powershell -ArgumentList "-NoExit -sta -ExecutionPolicy Bypass -File .\Start-TopologicalGitWatcher.ps1"
}

if (Test-Path ".\TopologicalMasterStudio.exe") {
    Write-Host "`n[+] Opening ACT-Ω Autopoietic Studio Control Center..." -ForegroundColor Cyan
    Start-Process -FilePath ".\TopologicalMasterStudio.exe"
}

Write-Host "`n============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Platform Active & Autopoietically Maintaining!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor DarkCyan
