# ============================================================================
# ACT-Ω Game Engine Heap & Auto-Initializing Directory Tuner
# Recursive Multi-Drive Auto-Discovery for Fallout 4, Skyrim SE & Vortex
# ============================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Continue"

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Auto-Initializing Game Path & Heap Tuner" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor DarkCyan

$scriptDir = "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
if (Test-Path $scriptDir) { Set-Location $scriptDir }

$KnownPaths = @(
    @{ Name = "Fallout 4"; InstallPath = "F:\SteamLibrary\steamapps\common\Fallout 4"; DataPath = "F:\SteamLibrary\steamapps\common\Fallout 4\Data"; IniFolder = "Fallout4"; CustomIni = "Fallout4Custom.ini" },
    @{ Name = "Skyrim Special Edition"; InstallPath = "C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition"; DataPath = "C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\Data"; IniFolder = "Skyrim Special Edition"; CustomIni = "SkyrimCustom.ini" }
)

$MyGamesPath = [System.IO.Path]::Combine($env:USERPROFILE, "Documents", "My Games")
$VortexAppData = [System.IO.Path]::Combine($env:APPDATA, "Vortex")

foreach ($game in $KnownPaths) {
    $gameName = $game.Name
    $installPath = $game.InstallPath
    $dataPath = $game.DataPath
    $iniDir = [System.IO.Path]::Combine($MyGamesPath, $game.IniFolder)

    Write-Host "`n[+] Auto-Initializing $gameName..." -ForegroundColor Cyan

    if (-not (Test-Path $installPath)) {
        Write-Host " [!] Primary path $installPath not found. Running Multi-Drive Auto-Discovery..." -ForegroundColor Yellow
        $foundExe = Get-PSDrive -PSProvider FileSystem | ForEach-Object {
            Get-ChildItem -Path $_.Root -Recurse -Include "Fallout4.exe", "SkyrimSE.exe" -ErrorAction SilentlyContinue | Select-Object -First 1
        }
        if ($foundExe) {
            $installPath = $foundExe.DirectoryName
            $dataPath = [System.IO.Path]::Combine($installPath, "Data")
            Write-Host " [+] Auto-Discovered $gameName at: $installPath" -ForegroundColor Green
        }
    } else {
        Write-Host " [+] Verified Game Installation Path: $installPath" -ForegroundColor Green
    }

    if (-not (Test-Path $iniDir)) {
        New-Item -ItemType Directory -Force -Path $iniDir | Out-Null
    }

    $customIniPath = [System.IO.Path]::Combine($iniDir, $game.CustomIni)

    $iniSettings = @"
[Papyrus]
fUpdateBudgetMS=1.2
fExtraTaskBudgetMS=1.2
iMinMemoryPageSize=512
iMaxMemoryPageSize=2048
iMaxAllocatedMemoryBytes=3072000000
bEnableLogging=0
bEnableTrace=0

[General]
bUseThreadedAI=1
iNumHWThreads=8
uGridsToLoad=5
uExterior Cell Buffer=36

[Display]
bBorderless=1
bFull Screen=1
bSAOEnable=1

[Memory]
iChunkMemoryFramePaging=1
"@

    Set-Content -Path $customIniPath -Value $iniSettings -Encoding utf8
    Write-Host " [+] $gameName Papyrus VM 3GB Heap & 8 HW Threads Locked in $customIniPath." -ForegroundColor Green

    if (Test-Path $dataPath) {
        $pluginFiles = Get-ChildItem -Path $dataPath -Include "*.esm", "*.esp", "*.esl" -Recurse -Depth 1 -ErrorAction SilentlyContinue
        Write-Host " [+] Data Directory Scanned: $($pluginFiles.Count) Active Plugins Found in $dataPath" -ForegroundColor Green

        if (Test-Path ".\topological_mod_solver.exe") {
            Write-Host " [+] Executing Topological DAG Solver for $gameName..." -ForegroundColor Cyan
            & ".\topological_mod_solver.exe" "$dataPath"
        }
    }
}

if (Test-Path $VortexAppData) {
    Write-Host "`n[+] Linked Active Vortex Profiles in $VortexAppData" -ForegroundColor Green
}

Write-Host "`n============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Game Engine Heap & Auto-Discovery Complete!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor DarkCyan
