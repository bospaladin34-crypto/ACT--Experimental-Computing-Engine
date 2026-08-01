Set-Location "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
try { Stop-Process -Name "topological_agent_daemon" -Force -ErrorAction SilentlyContinue } catch {}

if (-not (Test-Path ".\topological_agent_daemon.exe")) {
    rustc -O topological_agent_daemon.rs -o topological_agent_daemon.exe
}

if (Test-Path ".\topological_agent_daemon.exe") {
    Write-Host "[+] Spawning Continuous Background Agentic Daemon (15.965 Hz Cadence Lock)..." -ForegroundColor Green
    Start-Process -FilePath ".\topological_agent_daemon.exe" -WindowStyle Hidden
    Write-Host "[+] Continuous Agentic Daemon Active in Background!" -ForegroundColor Cyan
}
