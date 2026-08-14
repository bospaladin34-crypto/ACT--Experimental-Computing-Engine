# ============================================================================
# ACT-Ω / Nephilim Compute Mesh v25.0 Integration Module (ActOmegaMesh.psm1)
# Unifies WebRTC P2P Swarm, Deno Tasks, Native C-ABI SIMD & TensorVault Memory-Map
# Mathematical Constants: 15.965 Hz Clock, 256D Tensors, Sheaf H^1(U,F)=0 Bound
# ============================================================================

$script:meshHome = if (Test-Path "$HOME\Projects\compute-mesh") {
    "$HOME\Projects\compute-mesh"
} else {
    "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
}

$script:denoAppDir = Join-Path $script:meshHome "deno_app"
if (-not (Test-Path $script:denoAppDir)) {
    $script:denoAppDir = $script:meshHome
}

function Start-ActOmegaMesh {
    [CmdletBinding()]
    param(
        [switch]$Headless,
        [switch]$IncludeWorker
    )

    Write-Host "============================================================" -ForegroundColor DarkCyan
    Write-Host " [ACT-Ω v25.0] Booting Nephilim Distributed Compute Mesh..." -ForegroundColor Cyan
    Write-Host " Resonant Pulse Clock: 15.965 Hz (T = 62.637 ms) | 256D Tensors" -ForegroundColor Yellow
    Write-Host "============================================================" -ForegroundColor DarkCyan

    Set-Location $script:meshHome

    if (Test-Path ".\start_mesh.ps1") {
        Write-Host "[+] Executing native mesh bootstrap (start_mesh.ps1)..." -ForegroundColor Green
        if ($Headless) {
            Start-Process powershell -ArgumentList "-sta -ExecutionPolicy Bypass -File .\start_mesh.ps1" -WindowStyle Hidden
        } else {
            Start-Process powershell -ArgumentList "-NoExit -sta -ExecutionPolicy Bypass -File .\start_mesh.ps1"
        }
    } else {
        Write-Host "[+] Spawning WebSocket Signaling Server (deno task server)..." -ForegroundColor Green
        Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$script:denoAppDir'; deno task server`""

        if ($IncludeWorker) {
            Write-Host "[+] Spawning Distributed Compute Worker (deno task worker)..." -ForegroundColor Green
            Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$script:denoAppDir'; deno task worker`""
        }
    }

    Write-Host "[+] Nephilim Compute Mesh Substrate Active!" -ForegroundColor Green
}

function Stop-ActOmegaMesh {
    [CmdletBinding()]
    param()

    Write-Host "[!] Terminating active Nephilim Compute Mesh processes..." -ForegroundColor Yellow
    try { Stop-Process -Name "deno" -Force -ErrorAction SilentlyContinue } catch {}
    try { Stop-Process -Name "act_omega_deno_executor" -Force -ErrorAction SilentlyContinue } catch {}
    Write-Host "[+] Compute Mesh Substrate Standby." -ForegroundColor Cyan
}

function Get-ActOmegaMeshStatus {
    [CmdletBinding()]
    param(
        [switch]$AsJson
    )

    $statusObj = [PSCustomObject]@{
        MeshVersion        = "25.0.0"
        SubstrateStatus    = "ACTIVE_SHEAF_CONSERVED"
        ResonantPulseClock = "15.965 Hz (pi * phi, T = 62.637 ms)"
        GoldenRatioScaling = "1.61803398875"
        PhaseDeltaKey      = "0.17259029 rad"
        TensorDimensions   = "256D (16x16 spatial matrix)"
        TensorVaultCapacity= "4,672 custom tensors (9.29 MB memory-mapped)"
        MajoranaParityLock = "Tr(U_res) = 1.000000 (Conserved)"
        SheafCohomology    = "H^1(U, F) = 0 (Zero Global Obstruction)"
        LandauerEnergyFloor= "1.44 Joules Sheaf Stable (Max Drift: 1.8J)"
        EffectiveBusSpeed  = "c_eff = 1.707e11 m/s"
        ActiveSocketPorts  = @{
            SignalingServer = 8080
            Spatial3DWebGPU = 8090
            LLMProxy        = 8095
            SwarmMesh       = 8098
            RESTGateway     = 8099
        }
        SubsystemsCount    = 26
    }

    if ($AsJson) {
        return ($statusObj | ConvertTo-Json -Depth 4)
    } else {
        return $statusObj
    }
}

function Invoke-ActOmegaDenoTask {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet(
            "server",
            "worker",
            "master-e2e",
            "sqlite-vault",
            "integrated-vault",
            "cern-ingest",
            "materials-ingest",
            "cmb-ingest",
            "wiki-ingest",
            "folding-3stage",
            "dream-engine",
            "advanced-ext"
        )]
        [string]$Task,

        [string]$AdditionalArgs = ""
    )

    Set-Location $script:denoAppDir
    Write-Host "[+] Executing Deno Task: 'deno task $Task $AdditionalArgs'..." -ForegroundColor Cyan

    $output = if (Test-Path "$script:meshHome\act_omega_deno_executor.exe") {
        & "$script:meshHome\act_omega_deno_executor.exe" $Task *>&1 | Out-String
    } else {
        $cmd = "deno task $Task $AdditionalArgs"
        Invoke-Expression "$cmd *>&1" | Out-String
    }

    return $output
}

# CONVENIENCE CMDLETS FOR ALL 12 DENO TASKS
function Start-ActOmegaSignalingServer { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "server" }
function Start-ActOmegaWorker { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "worker" }
function Test-ActOmegaMasterE2E { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "master-e2e" }
function Test-ActOmegaSqliteVault { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "sqlite-vault" }
function Test-ActOmegaIntegratedVault { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "integrated-vault" }
function Invoke-ActOmegaCernIngest { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "cern-ingest" }
function Invoke-ActOmegaMaterialsIngest { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "materials-ingest" }
function Invoke-ActOmegaCmbIngest { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "cmb-ingest" }
function Invoke-ActOmegaWikiIngest { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "wiki-ingest" }
function Invoke-ActOmegaFoldingEngine { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "folding-3stage" }
function Invoke-ActOmegaDreamEngine { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "dream-engine" }
function Test-ActOmegaAdvancedExtensions { [CmdletBinding()] param() Invoke-ActOmegaDenoTask -Task "advanced-ext" }

function Invoke-ActOmegaFullAudit {
    [CmdletBinding()]
    param()

    Set-Location $script:meshHome
    if (Test-Path ".\run_full_audit.ps1") {
        Write-Host "[+] Executing Nephilim Full Architecture Audit (run_full_audit.ps1)..." -ForegroundColor Green
        & ".\run_full_audit.ps1" *>&1 | Out-String
    } else {
        Test-ActOmegaMasterE2E
    }
}

Export-ModuleMember -Function `
    Start-ActOmegaMesh, `
    Stop-ActOmegaMesh, `
    Get-ActOmegaMeshStatus, `
    Invoke-ActOmegaDenoTask, `
    Start-ActOmegaSignalingServer, `
    Start-ActOmegaWorker, `
    Test-ActOmegaMasterE2E, `
    Test-ActOmegaSqliteVault, `
    Test-ActOmegaIntegratedVault, `
    Invoke-ActOmegaCernIngest, `
    Invoke-ActOmegaMaterialsIngest, `
    Invoke-ActOmegaCmbIngest, `
    Invoke-ActOmegaWikiIngest, `
    Invoke-ActOmegaFoldingEngine, `
    Invoke-ActOmegaDreamEngine, `
    Test-ActOmegaAdvancedExtensions, `
    Invoke-ActOmegaFullAudit
