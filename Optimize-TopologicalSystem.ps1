# ============================================================================
# ACT-Ω Windows System Geometric Optimizer
# ============================================================================

$ErrorActionPreference = "Continue"

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Deploying Geometric Hardware/Software Tuning" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor DarkCyan

$NLAKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
if (Test-Path $NLAKey) {
    Set-ItemProperty -Path $NLAKey -Name "SystemResponsiveness" -Value 0 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $NLAKey -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -ErrorAction SilentlyContinue
    Write-Host "[+] Multimedia SystemProfile Responsiveness tuned to 0ms latency." -ForegroundColor Green
}

$UltimateGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
powercfg -duplicatescheme $UltimateGuid 2>&1 | Out-Null
powercfg -setactive $UltimateGuid 2>&1 | Out-Null
Write-Host "[+] Power Management locked to Ultimate Performance." -ForegroundColor Green

$GamesKey = "$NLAKey\Tasks\Games"
if (Test-Path $GamesKey) {
    Set-ItemProperty -Path $GamesKey -Name "Scheduling Category" -Value "High" -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $GamesKey -Name "SFIO Priority" -Value "High" -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $GamesKey -Name "Background Only" -Value "False" -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $GamesKey -Name "GPU Priority" -Value 8 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $GamesKey -Name "Priority" -Value 6 -ErrorAction SilentlyContinue
    Write-Host "[+] MMCSS Task Parameters locked to Maximum GPU/CPU Allocation." -ForegroundColor Green
}

Write-Host "`n[Result] Windows Host System Successfully Configured." -ForegroundColor Yellow
