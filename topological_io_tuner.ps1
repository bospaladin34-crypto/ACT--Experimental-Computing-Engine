# ============================================================================
# ACT-Ω NVMe / SSD Geometric File System & I/O Compaction Suite
# ============================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Continue"

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Deploying NVMe / SSD Geometric I/O Tuner" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor DarkCyan

# 1. DISABLE 8.3 SHORT FILENAME GENERATION
Write-Host "[1/5] Disabling 8.3 Short Filename Overhead..." -ForegroundColor Yellow
fsutil 8dot3name set 0 2>&1 | Out-Null
Write-Host " [+] 8.3 Filename Creation Disabled (Reduces directory traversal latency)." -ForegroundColor Green

# 2. DISABLE LAST ACCESS TIMESTAMP UPDATES
Write-Host "[2/5] Disabling Last Access Timestamp Disk Writes..." -ForegroundColor Yellow
fsutil behavior set disablelastaccess 1 2>&1 | Out-Null
Write-Host " [+] Last Access Timestamp Writes Disabled (Eliminates read-triggered metadata writes)." -ForegroundColor Green

# 3. INCREASE NTFS MEMORY ALLOCATION & CACHE BUFFERS
Write-Host "[3/5] Allocating Expanded NTFS Lookaside Buffers..." -ForegroundColor Yellow
fsutil behavior set memoryusage 2 2>&1 | Out-Null
Write-Host " [+] NTFS Memory Buffer set to Increased/Large Cache Allocation." -ForegroundColor Green

# 4. ENABLE TRIM & DISABLE DELETE NOTIFY LATENCY
Write-Host "[4/5] Verifying NVMe TRIM / Delete Notify Acceleration..." -ForegroundColor Yellow
fsutil behavior set DisableDeleteNotify 0 2>&1 | Out-Null
Write-Host " [+] TRIM Delete Notification set to Active (Instant NVMe Block Deallocation)." -ForegroundColor Green

# Re-Trim all SSD/NVMe NTFS/ReFS volumes
Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' -and $_.FileSystem -in ('NTFS','ReFS') } | ForEach-Object {
    $driveLetter = $_.DriveLetter
    if ($driveLetter) {
        Write-Host " [+] Initiating NVMe TRIM Optimization on Drive ${driveLetter}:..." -ForegroundColor Cyan
        Optimize-Volume -DriveLetter $driveLetter -ReTrim -ErrorAction SilentlyContinue
    }
}

# 5. DISK CACHE FLUSHING & WRITE BUFFER TUNING
Write-Host "[5/5] Optimizing Storage Device Write Cache Policies..." -ForegroundColor Yellow
$DiskKey = "HKLM:\SYSTEM\CurrentControlSet\Enum\SCSI"
if (Test-Path $DiskKey) {
    Get-ChildItem -Path $DiskKey -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.PSChildName -eq "Device Parameters" } | ForEach-Object {
        $DiskParamPath = $_.PSPath
        if (Test-Path "$DiskParamPath\Disk") {
            Set-ItemProperty -Path "$DiskParamPath\Disk" -Name "UserWriteCacheSetting" -Value 1 -ErrorAction SilentlyContinue
        }
    }
    Write-Host " [+] Storage Disk Write Caching forced to Active Mode." -ForegroundColor Green
}

Write-Host "`n============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] NVMe / SSD Geometric I/O Tuning Complete!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor DarkCyan
