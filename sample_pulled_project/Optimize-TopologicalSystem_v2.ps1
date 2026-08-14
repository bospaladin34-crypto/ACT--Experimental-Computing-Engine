# ============================================================================
# ACT-Ω Windows System Geometric Optimizer v2.0 (Extreme Efficiency Suite)
# ============================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Continue"

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Deploying Phase 2 Extreme Efficiency Suite" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor DarkCyan

# 1. KERNEL & MEMORY MANAGEMENT OPTIMIZATION
Write-Host "[1/4] Tuning Kernel Memory & Page Table Allocation..." -ForegroundColor Yellow

$MemMgmtKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
if (Test-Path $MemMgmtKey) {
    Set-ItemProperty -Path $MemMgmtKey -Name "DisablePagingExecutive" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $MemMgmtKey -Name "LargeSystemCache" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $MemMgmtKey -Name "EncryptPagingFile" -Value 0 -ErrorAction SilentlyContinue
    Write-Host " [+] Kernel locked to physical RAM; Large System Cache activated." -ForegroundColor Green
}

try {
    Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue
    Write-Host " [+] Memory Compression disabled for zero-latency page allocation." -ForegroundColor Green
} catch {
    Write-Host " [!] MMAgent command skipped or unneeded." -ForegroundColor Gray
}

# 2. CPU TOPOLOGY & CORE PARKING DISABLING
Write-Host "[2/4] Eliminating CPU Core Parking & Unlocking Aggressive Boost..." -ForegroundColor Yellow

powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR 0cc5b647-c1df-4637-891a-dec35c318583 100 2>&1 | Out-Null
powercfg -setactive SCHEME_CURRENT 2>&1 | Out-Null

powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR be337238-0d82-4146-a960-4f3749d470c7 2 2>&1 | Out-Null
powercfg -setactive SCHEME_CURRENT 2>&1 | Out-Null
Write-Host " [+] All CPU Cores forced active; Core Parking 100% disabled." -ForegroundColor Green

# 3. GPU & DIRECTX PIPELINE OPTIMIZATION
Write-Host "[3/4] Optimizing Graphics Pipeline & HAGS (Hardware Scheduling)..." -ForegroundColor Yellow

$GraphicsKey = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
if (Test-Path $GraphicsKey) {
    Set-ItemProperty -Path $GraphicsKey -Name "HwSchMode" -Value 2 -ErrorAction SilentlyContinue
    Write-Host " [+] Hardware-Accelerated GPU Scheduling (HAGS) set to Active." -ForegroundColor Green
}

$GameDVRKey = "HKCU:\System\GameConfigStore"
if (Test-Path $GameDVRKey) {
    Set-ItemProperty -Path $GameDVRKey -Name "GameDVR_Enabled" -Value 0 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $GameDVRKey -Name "GameDVR_FSEBehaviorMode" -Value 2 -ErrorAction SilentlyContinue
    Write-Host " [+] Background GameDVR & Fullscreen Latency overhead eliminated." -ForegroundColor Green
}

# 4. NETWORK STACK & TCP SOCKET LATENCY
Write-Host "[4/4] Tuning TCP/IP Sockets & Disabling Nagle Latency Buffer..." -ForegroundColor Yellow

netsh int tcp set global autotuninglevel=normal 2>&1 | Out-Null
netsh int tcp set global congestionprovider=ctcp 2>&1 | Out-Null
netsh int tcp set global ecncapability=enabled 2>&1 | Out-Null
netsh int tcp set global timestamps=disabled 2>&1 | Out-Null
netsh int tcp set global rss=enabled 2>&1 | Out-Null
netsh int tcp set global rsc=enabled 2>&1 | Out-Null

$InterfacesKey = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
if (Test-Path $InterfacesKey) {
    Get-ChildItem -Path $InterfacesKey | ForEach-Object {
        Set-ItemProperty -Path $_.PSPath -Name "TcpAckFrequency" -Value 1 -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $_.PSPath -Name "TCPNoDelay" -Value 1 -ErrorAction SilentlyContinue
    }
    Write-Host " [+] TCP Socket Latency minimized (TCPNoDelay & Immediate ACK)." -ForegroundColor Green
}

Write-Host "`n============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Extreme System Optimization Complete!" -ForegroundColor Green
Write-Host " (Reboot recommended for HAGS & Kernel Page Locking to activate)" -ForegroundColor Gray
Write-Host "============================================================" -ForegroundColor DarkCyan
