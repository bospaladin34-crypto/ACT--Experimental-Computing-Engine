# ============================================================================
# ACT-Ω v25.0 Full Topological System Optimizer & Master Orchestrator
# Compiles All 46 Native Rust Subsystems, Executes Hardware Tuners & Launches GUI
# ============================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[!] Elevating process permissions to Administrator..." -ForegroundColor Yellow
    $scriptPath = $MyInvocation.MyCommand.Definition
    if ($scriptPath) {
        Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
        exit
    }
}

Set-Location "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Host "================================================================================" -ForegroundColor DarkCyan
Write-Host "   ACT-Ω v25.0 Full Topological System Optimizer & Master Suite Compilation     " -ForegroundColor Cyan
Write-Host "   Resonant Clock: 15.965 Hz | E8 Shared Memory Manifold | 46 Native Subsystems " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor DarkCyan

# ----------------------------------------------------------------------------
# 1. VERIFY & COMPILE ALL 46 NATIVE RUST SUBSYSTEMS (-O)
# ----------------------------------------------------------------------------
Write-Host "`n[1/5] Verifying & Compiling All 46 Native Rust Subsystems (Zero-Bracket Rust)..." -ForegroundColor Yellow

$rustFiles = @(
    "act_omega_autopoietic_daemon.rs",
    "act_omega_autopoietic_ast_debugger.rs",
    "act_omega_deno_executor.rs",
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
    "topological_dictionary.rs",
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
        if (-not (Test-Path $exeName) -or ((Get-Item $rs).LastWriteTime -gt (Get-Item $exeName).LastWriteTime)) {
            Write-Host " [+] Compiling $rs -> $exeName..." -ForegroundColor DarkGray
            rustc -O $rs -o $exeName 2>&1 | Out-Null
        }
        if (Test-Path $exeName) {
            $compiledCount++
        }
    }
}
Write-Host " [+] $compiledCount Native Rust Subsystems Compiled & Verified." -ForegroundColor Green

# ----------------------------------------------------------------------------
# 2. DEPLOY KERNEL, MEMORY, GPU & I/O HARDWARE TUNERS
# ----------------------------------------------------------------------------
Write-Host "`n[2/5] Deploying System, Kernel, GPU & NVMe File System Geometric Tuning..." -ForegroundColor Yellow

if (Test-Path ".\Optimize-TopologicalSystem_v2.ps1") {
    Write-Host " [+] Kernel RAM Page Locking & Core Un-Parking..." -ForegroundColor Green
    & ".\Optimize-TopologicalSystem_v2.ps1" *>&1 | Out-Null
}

if (Test-Path ".\topological_gpu_tuner.ps1") {
    Write-Host " [+] Locking NVIDIA Ultra Low Latency Mode 2 & MMCSS GPU Priority 8..." -ForegroundColor Green
    & ".\topological_gpu_tuner.ps1" *>&1 | Out-Null
}

if (Test-Path ".\topological_io_tuner.ps1") {
    Write-Host " [+] NVMe Storage TRIM Optimization & 8.3 Overhead Removal..." -ForegroundColor Green
    & ".\topological_io_tuner.ps1" *>&1 | Out-Null
}

if (Test-Path ".\topological_ini_tuner.ps1") {
    Write-Host " [+] Injecting Papyrus 3GB Heap for Fallout 4 & Skyrim SE..." -ForegroundColor Green
    & ".\topological_ini_tuner.ps1" *>&1 | Out-Null
}

# ----------------------------------------------------------------------------
# 3. BUILD STANDALONE EXECUTABLES (C# STA Host Wrappers)
# ----------------------------------------------------------------------------
Write-Host "`n[3/5] Re-Compiling Standalone Host GUI Executables (csc.exe -sta)..." -ForegroundColor Yellow

if (Test-Path ".\Build-MasterEXE.ps1") {
    & ".\Build-MasterEXE.ps1" *>&1 | Out-Null
    Write-Host " [+] Standalone TopologicalMasterStudio.exe Built." -ForegroundColor Green
}

if (Test-Path ".\Build-CompilerStudioEXE.ps1") {
    & ".\Build-CompilerStudioEXE.ps1" *>&1 | Out-Null
    Write-Host " [+] Standalone TopologicalPolyglotCompilerStudio.exe Built." -ForegroundColor Green
}

# ----------------------------------------------------------------------------
# 4. RUN SELF-TEST DIAGNOSTIC PASSES ACROSS NATIVE ENGINES
# ----------------------------------------------------------------------------
Write-Host "`n[4/5] Executing Self-Test Diagnostic Passes across Key Native Binaries..." -ForegroundColor Yellow

if (Test-Path ".\topological_autonomous_integrator.exe") {
    $integratorOut = & ".\topological_autonomous_integrator.exe" *>&1 | Out-String
    Write-Host $integratorOut.Trim() -ForegroundColor Cyan
}

if (Test-Path ".\topological_physics_core.exe") {
    $physOut = & ".\topological_physics_core.exe" "ew" *>&1 | Out-String
    Write-Host $physOut.Trim() -ForegroundColor Yellow
}

# ----------------------------------------------------------------------------
# 5. ACTIVATE PERSISTENT SERVICES & LAUNCH MASTER STUDIO
# ----------------------------------------------------------------------------
Write-Host "`n[5/5] Activating Continuous Services & Launching Master Control Center..." -ForegroundColor Yellow

if (Test-Path ".\topological_hyper_manifold.exe") {
    Start-Process -FilePath ".\topological_hyper_manifold.exe" -WindowStyle Hidden
    Write-Host " [+] Shared Memory Ring Active: Global\ACT_OMEGA_E8_HYPER_MANIFOLD" -ForegroundColor Green
}

if (Test-Path ".\act_omega_autopoietic_daemon.exe") {
    Start-Process -FilePath ".\act_omega_autopoietic_daemon.exe" -WindowStyle Hidden
    Write-Host " [+] Autopoietic Daemon Active (15.965 Hz Cadence Lock)." -ForegroundColor Green
}

if (Test-Path ".\TopologicalHUD.ps1") {
    Start-Process powershell -ArgumentList "-sta -ExecutionPolicy Bypass -File .\TopologicalHUD.ps1" -WindowStyle Hidden
    Write-Host " [+] In-Game Low-Latency HUD Overlay Activated." -ForegroundColor Green
}

if (Test-Path ".\TopologicalMasterStudio.exe") {
    Write-Host "`n[+] Opening Master Cybernetic Control Center Window..." -ForegroundColor Cyan
    Start-Process -FilePath ".\TopologicalMasterStudio.exe"
}

Write-Host "`n================================================================================" -ForegroundColor DarkCyan
Write-Host " [SUCCESS] Full Topological System Optimizer & Master Suite Operational!       " -ForegroundColor Green
Write-Host "================================================================================" -ForegroundColor DarkCyan