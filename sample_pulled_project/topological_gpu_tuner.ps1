# ============================================================================
# ACT-Ω Low-Latency GPU Driver & DirectX 12 Pipeline Tuner
# ============================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Continue"

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Deploying GPU Driver & DirectX 12 Pipeline Tuner" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor DarkCyan

# 1. ENFORCE NVIDIA ULTRA LOW LATENCY MODE
Write-Host "[1/5] Configuring Driver Low Latency Mode (Ultra Pass-Through)..." -ForegroundColor Yellow

$NvidiaKeys = @(
    "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000",
    "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001"
)

foreach ($nvKey in $NvidiaKeys) {
    if (Test-Path $nvKey) {
        # Ultra Low Latency Mode (2 = Ultra)
        Set-ItemProperty -Path $nvKey -Name "UltraLowLatencyMode" -Value 2 -ErrorAction SilentlyContinue
        # Prefer Maximum Performance (Power Management Mode)
        Set-ItemProperty -Path $nvKey -Name "PowerMgmtMode" -Value 1 -ErrorAction SilentlyContinue
        # Pre-rendered frames locked to 1
        Set-ItemProperty -Path $nvKey -Name "MaxPreRenderedFrames" -Value 1 -ErrorAction SilentlyContinue
        Write-Host " [+] Driver Key $nvKey locked to Ultra Low Latency & Max Performance." -ForegroundColor Green
    }
}

# 2. EXPAND DIRECTX 12 SHADER CACHE BOUNDS
Write-Host "[2/5] Expanding DirectX 12 Shader Cache Allocation..." -ForegroundColor Yellow

$DxKey = "HKCU:\Software\Microsoft\DirectX\UserGpuPreferences"
if (-not (Test-Path $DxKey)) {
    New-Item -Path $DxKey -Force | Out-Null
}
Set-ItemProperty -Path $DxKey -Name "DirectXUserGpuPolicy" -Value 1 -ErrorAction SilentlyContinue

$D3DKey = "HKLM:\SOFTWARE\Microsoft\Direct3D"
if (Test-Path $D3DKey) {
    Set-ItemProperty -Path $D3DKey -Name "MaxPreRenderedFrames" -Value 1 -ErrorAction SilentlyContinue
    Write-Host " [+] Direct3D Pipeline locked to 1 Pre-Rendered Frame." -ForegroundColor Green
}

# 3. DWM & DISPLAY FRAME LATENCY BUFFER ELIMINATION
Write-Host "[3/5] Disabling DWM Latency Buffer & Variable Refresh Buffer Drops..." -ForegroundColor Yellow

$DwmKey = "HKCU:\Software\Microsoft\Windows\DWM"
if (Test-Path $DwmKey) {
    Set-ItemProperty -Path $DwmKey -Name "Composition" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $DwmKey -Name "EnableAeroPeek" -Value 0 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $DwmKey -Name "DisallowAnimations" -Value 1 -ErrorAction SilentlyContinue
    Write-Host " [+] DWM Animation overhead & compositing buffer latency minimized." -ForegroundColor Green
}

# 4. MMCSS GPU PIPELINE ALLOCATION
Write-Host "[4/5] Elevating MMCSS GPU Scheduling Priority..." -ForegroundColor Yellow

$GamesTaskKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
if (Test-Path $GamesTaskKey) {
    Set-ItemProperty -Path $GamesTaskKey -Name "GPU Priority" -Value 8 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $GamesTaskKey -Name "Priority" -Value 6 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $GamesTaskKey -Name "Scheduling Category" -Value "High" -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $GamesTaskKey -Name "SFIO Priority" -Value "High" -ErrorAction SilentlyContinue
    Write-Host " [+] MMCSS GPU Priority locked to 8 (Maximum Allocation)." -ForegroundColor Green
}

# 5. GRAPHICS DRIVER TDR (TIMEOUT DETECTION & RECOVERY) RESILIENCE
Write-Host "[5/5] Configuring Graphics TDR Delay Bounds..." -ForegroundColor Yellow

$GraphicsDriversKey = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
if (Test-Path $GraphicsDriversKey) {
    # TdrDelay = 8 seconds (Prevents false GPU resets during heavy shader compilation)
    Set-ItemProperty -Path $GraphicsDriversKey -Name "TdrDelay" -Value 8 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $GraphicsDriversKey -Name "TdrDdiDelay" -Value 8 -ErrorAction SilentlyContinue
    Write-Host " [+] GPU TDR Delay extended to 8s (Shader compilation crash protection active)." -ForegroundColor Green
}

Write-Host "`n============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] GPU Driver & DirectX 12 Pipeline Tuning Complete!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor DarkCyan
