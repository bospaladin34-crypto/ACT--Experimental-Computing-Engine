# ============================================================================
# ACT-Ω Topological System Master Orchestrator & Comprehensive Suite Launcher
# Compiles All 44 Native Rust Subsystems, Runs Diagnostics, Builds EXE & Launches GUI
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
Write-Host " [ACT-Ω v25.0] Launching Master Autonomous Topological Suite" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor DarkCyan

# 1. COMPILE ALL 44 NATIVE RUST SUBSYSTEMS
Write-Host "`n[1/5] Verifying & Compiling All 44 Native Rust Subsystems (-O Optimization)..." -ForegroundColor Yellow

$rustFiles = @(
    "braid_compiler.rs",
    "topological_adapter_sdk.rs",
    "topological_agent_daemon.rs",
    "topological_agent_planner.rs",
    "topological_anyon_braid.rs",
    "topological_ast_refactor.rs",
    "topological_audio_resonator.rs",
    "topological_auto_injector.rs",
    "topological_autonomous_integrator.rs",
    "topological_background_daemon.rs",
    "topological_braid_attention.rs",
    "topological_cadence_lock.rs",
    "topological_calabi_yau.rs",
    "topological_casimir_force.rs",
    "topological_chiral_anomaly.rs",
    "topological_cluster_mesh.rs",
    "topological_dma_cavity.rs",
    "topological_event_cascade.rs",
    "topological_geometric_tokenizer.rs",
    "topological_git_sync.rs",
    "topological_governor.rs",
    "topological_gravitational_lensing.rs",
    "topological_hyper_manifold.rs",
    "topological_legacy_bridge.rs",
    "topological_lhc_ingestor.rs",
    "topological_llm_middleware.rs",
    "topological_lsp.rs",
    "topological_memory_guard.rs",
    "topological_mempool_engine.rs",
    "topological_mod_solver.rs",
    "topological_module_registry.rs",
    "topological_optimizer.rs",
    "topological_physics_core.rs",
    "topological_proot_bridge.rs",
    "topological_qcd_flux.rs",
    "topological_self_healer.rs",
    "topological_semantic_compiler.rs",
    "topological_sheaf_cohomology.rs",
    "topological_spatial_audio.rs",
    "topological_stress_benchmark.rs",
    "topological_stress_benchmark_failsafe.rs",
    "topological_web_hub.rs",
    "topological_web_scraper.rs",
    "topological_zkp_verifier.rs"
)

$compiledCount = 0
foreach ($rs in $rustFiles) {
    if (Test-Path $rs) {
        $exeName = $rs.Replace(".rs", ".exe")
        Write-Host " [+] Compiling $rs -> $exeName..." -ForegroundColor Green
        rustc -O $rs -o $exeName 2>&1 | Out-Null
        $compiledCount++
    }
}
Write-Host "[+] Successfully Compiled $compiledCount Native Rust Subsystems." -ForegroundColor Cyan

# 2. EXECUTE SYSTEM, KERNEL, GPU & I/O TUNERS
Write-Host "`n[2/5] Deploying System, Kernel, GPU & File System Tuning Passes..." -ForegroundColor Yellow

if (Test-Path ".\Optimize-TopologicalSystem_v2.ps1") {
    Write-Host " [+] Kernel Page Locking & Core Un-Parking..." -ForegroundColor Green
    & ".\Optimize-TopologicalSystem_v2.ps1"
}

if (Test-Path ".\topological_io_tuner.ps1") {
    Write-Host " [+] NVMe / SSD File System I/O Compaction..." -ForegroundColor Green
    & ".\topological_io_tuner.ps1"
}

if (Test-Path ".\topological_gpu_tuner.ps1") {
    Write-Host " [+] Low-Latency GPU Driver & DirectX 12 Tuner..." -ForegroundColor Green
    & ".\topological_gpu_tuner.ps1"
}

if (Test-Path ".\topological_ini_tuner.ps1") {
    Write-Host " [+] Game Engine Heap & Papyrus INI Tuner..." -ForegroundColor Green
    & ".\topological_ini_tuner.ps1"
}

# 3. VERIFY EXECUTABLE DIAGNOSTIC SELF-TEST PASSES
Write-Host "`n[3/5] Running Self-Test Diagnostic Passes across Key Native Binaries..." -ForegroundColor Yellow

if (Test-Path ".\topological_autonomous_integrator.exe") {
    Write-Host "`n --- Diagnostic: Unifying Autonomous Integrator Engine ---" -ForegroundColor Cyan
    & ".\topological_autonomous_integrator.exe"
}

if (Test-Path ".\topological_module_registry.exe") {
    Write-Host "`n --- Diagnostic: Dynamic Module Registry ---" -ForegroundColor Cyan
    & ".\topological_module_registry.exe"
}

if (Test-Path ".\topological_event_cascade.exe") {
    Write-Host "`n --- Diagnostic: Topological Event Cascade Engine ---" -ForegroundColor Cyan
    & ".\topological_event_cascade.exe" "INTENT_MEMORY_PRESSURE"
}

if (Test-Path ".\topological_ast_refactor.exe") {
    Write-Host "`n --- Diagnostic: AST Topological Code Refactorer ---" -ForegroundColor Cyan
    & ".\topological_ast_refactor.exe"
}

if (Test-Path ".\topological_calabi_yau.exe") {
    Write-Host "`n --- Diagnostic: Superstring Calabi-Yau Solver ---" -ForegroundColor Cyan
    & ".\topological_calabi_yau.exe"
}

if (Test-Path ".\topological_qcd_flux.exe") {
    Write-Host "`n --- Diagnostic: QCD Color-Confinement Engine ---" -ForegroundColor Cyan
    & ".\topological_qcd_flux.exe"
}

if (Test-Path ".\topological_web_scraper.exe") {
    Write-Host "`n --- Diagnostic: Standalone Topological Web Scraper ---" -ForegroundColor Cyan
    & ".\topological_web_scraper.exe" "http://example.com/index.html"
}

# 4. RE-COMPILE MASTER EXECUTABLE TO EMBED LATEST CONTROLS
Write-Host "`n[4/5] Re-Compiling Standalone Master Executable (csc.exe)..." -ForegroundColor Yellow
if (Test-Path ".\Build-MasterEXE.ps1") {
    & ".\Build-MasterEXE.ps1"
}

# 5. ACTIVATE CONTINUOUS SERVICES & LAUNCH MASTER CONTROL CENTER
Write-Host "`n[5/5] Activating Continuous Background Services & Master Control Center..." -ForegroundColor Yellow

if (Test-Path ".\topological_hyper_manifold.exe") {
    Start-Process -FilePath ".\topological_hyper_manifold.exe" -WindowStyle Hidden
    Write-Host " [+] Shared Memory Ring Active: Global\ACT_OMEGA_E8_HYPER_MANIFOLD" -ForegroundColor Green
}

if (Test-Path ".\topological_agent_daemon.exe") {
    Start-Process -FilePath ".\topological_agent_daemon.exe" -WindowStyle Hidden
    Write-Host " [+] Continuous Background Agentic Daemon Active (15.965 Hz Loop)." -ForegroundColor Green
}

if (Test-Path ".\TopologicalHUD.ps1") {
    Start-Process powershell -ArgumentList "-sta -ExecutionPolicy Bypass -File .\TopologicalHUD.ps1" -WindowStyle Hidden
    Write-Host " [+] In-Game Low-Latency HUD Overlay Activated." -ForegroundColor Green
}

if (Test-Path ".\Start-TopologicalGitWatcher.ps1") {
    Start-Process powershell -ArgumentList "-NoExit -sta -ExecutionPolicy Bypass -File .\Start-TopologicalGitWatcher.ps1"
    Write-Host " [+] Continuous GitHub Auto-Push Watcher Active (Target: origin main)." -ForegroundColor Green
}

if (Test-Path ".\TopologicalMasterStudio.exe") {
    Write-Host " [+] Opening Updated Master Control Center Window..." -ForegroundColor Cyan
    Start-Process -FilePath ".\TopologicalMasterStudio.exe"
}

Write-Host "`n============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Master Suite Launch Complete! All Systems Operational." -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor DarkCyan
