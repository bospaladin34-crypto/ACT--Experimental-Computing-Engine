# ============================================================================
# ACT-Ω Direct PowerShell Master Studio Launcher (Run-MasterStudio.ps1)
# Launches TopologicalMasterStudio in STA Mode (-sta) directly
# ============================================================================

Set-Location "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
Write-Host "[+] Launching ACT-Ω Master Studio in Single-Threaded Apartment (-sta) Mode..." -ForegroundColor Green

if (Test-Path ".\TopologicalMasterStudio.exe") {
    Start-Process -FilePath ".\TopologicalMasterStudio.exe"
} else {
    powershell.exe -sta -ExecutionPolicy Bypass -File ".\TopologicalMasterStudio.ps1"
}