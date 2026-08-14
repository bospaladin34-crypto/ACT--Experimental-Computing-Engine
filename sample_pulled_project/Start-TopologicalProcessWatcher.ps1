# ============================================================================
# ACT-Ω Real-time Foreground Process Auto-Tuner Watcher
# ============================================================================

Write-Host "[ACT-Ω Watcher] Active. Dynamic Thread Priority & I/O Auto-Tuner running..." -ForegroundColor Cyan

$lastPid = 0

while ($true) {
    try {
        $fgProcess = Get-Process | Where-Object { $_.MainWindowHandle -ne 0 } | Sort-Object WorkingSet -Descending | Select-Object -First 1
        
        if ($fgProcess -and $fgProcess.Id -ne $lastPid -and $fgProcess.ProcessName -ne "explorer") {
            $lastPid = $fgProcess.Id
            $fgProcess.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
            Write-Host "[+] Accelerated Foreground Target: $($fgProcess.ProcessName) (PID: $($fgProcess.Id)) -> Priority: High" -ForegroundColor Green
        }
    } catch {}
    
    Start-Sleep -Seconds 3
}
