# ============================================================================
# ACT-Ω v25.0 Universal PowerShell Integration Module (ActOmega.psm1)
# Layer 1: Code Synthesis, E8 Shared Memory, Event Cascades
# Layer 2: Workspace Directory Discovery, Manifesting & Workspace Pull Engine
# ============================================================================

$script:actOmegaHome = "C:\sovereign_manifold\santos-sync\topological_system_optimizer"

# LAYER 1 CMDLETS
function Invoke-ActOmegaQuery {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Prompt,

        [Parameter(Position=1)]
        [ValidateSet("Python", "Rust", "C/C++", "TypeScript", "Deno FFI")]
        [string]$Language = "Python",

        [switch]$AsScriptBlock,

        [switch]$IncludeBraidIR
    )

    Set-Location $script:actOmegaHome

    $resultObj = [PSCustomObject]@{
        Prompt             = $Prompt
        Language           = $Language
        E8Vector           = $null
        BraidIRStream      = $null
        SynthesizedCode    = $null
        PowerShellDeployer = $null
    }

    if (Test-Path ".\topological_dictionary.exe") {
        $promptClean = $Prompt -replace "`r`n", " " -replace "`n", " "
        $resultObj.E8Vector = & ".\topological_dictionary.exe" $promptClean *>&1 | Out-String
    }

    if ($IncludeBraidIR -and (Test-Path ".\topological_geometric_tokenizer.exe")) {
        $promptClean = $Prompt -replace "`r`n", " " -replace "`n", " "
        $resultObj.BraidIRStream = & ".\topological_geometric_tokenizer.exe" $promptClean *>&1 | Out-String
    }

    if (Test-Path ".\topological_semantic_compiler.exe") {
        $promptClean = $Prompt -replace "`r`n", " " -replace "`n", " "
        $rawCode = & ".\topological_semantic_compiler.exe" $promptClean $Language *>&1 | Out-String
        $cleanSource = $rawCode -replace "^```[a-zA-Z]*`r?`n", "" -replace "`r?`n```$", ""
        $resultObj.SynthesizedCode = $cleanSource

        $langLower = $Language.ToLower()
        $ext = ".py"
        $execCmd = "python3 .\topological_generated_code.py"

        if ($langLower -eq "rust") {
            $ext = ".rs"
            $execCmd = "rustc -O topological_generated_code.rs -o topological_generated_code.exe`r`n.\topological_generated_code.exe"
        } elseif ($langLower -eq "c/c++") {
            $ext = ".cpp"
            $execCmd = "g++ -O3 topological_generated_code.cpp -o topological_generated_code.exe`r`n.\topological_generated_code.exe"
        } elseif ($langLower -eq "typescript") {
            $ext = ".ts"
            $execCmd = "deno run topological_generated_code.ts"
        }

        $psBlock = "Set-Location `"$script:actOmegaHome`"`r`n`r`n@'`r`n" + $cleanSource + "`r`n'@ | Out-File -FilePath `".\topological_generated_code" + $ext + "`" -Encoding utf8`r`n`r`n" + $execCmd
        $resultObj.PowerShellDeployer = $psBlock
    }

    if ($AsScriptBlock) {
        return $resultObj.PowerShellDeployer
    } else {
        return $resultObj
    }
}

function Get-ActOmegaSharedMemory {
    [CmdletBinding()]
    param()

    Set-Location $script:actOmegaHome
    if (Test-Path ".\topological_hyper_manifold.exe") {
        return & ".\topological_hyper_manifold.exe" *>&1 | Out-String
    } else {
        Write-Warning "topological_hyper_manifold.exe not found."
    }
}

function Optimize-ActOmegaSystem {
    [CmdletBinding()]
    param(
        [switch]$IncludeGames,
        [switch]$IncludeGPU
    )

    Set-Location $script:actOmegaHome
    Write-Host "[+] Executing ACT-Ω Kernel & Memory Page Optimization..." -ForegroundColor Green
    if (Test-Path ".\Optimize-TopologicalSystem_v2.ps1") {
        & ".\Optimize-TopologicalSystem_v2.ps1" *>&1 | Out-String
    }

    if ($IncludeGPU -and (Test-Path ".\topological_gpu_tuner.ps1")) {
        Write-Host "[+] Applying Low-Latency GPU Driver & DirectX Tuning..." -ForegroundColor Green
        & ".\topological_gpu_tuner.ps1" *>&1 | Out-String
    }

    if ($IncludeGames -and (Test-Path ".\topological_ini_tuner.ps1")) {
        Write-Host "[+] Injecting Papyrus Game Engine 3GB Heap..." -ForegroundColor Green
        & ".\topological_ini_tuner.ps1" *>&1 | Out-String
    }
}

function Protect-ActOmegaMemory {
    [CmdletBinding()]
    param()

    Set-Location $script:actOmegaHome
    if (Test-Path ".\topological_memory_guard.exe") {
        return & ".\topological_memory_guard.exe" *>&1 | Out-String
    } else {
        Write-Warning "topological_memory_guard.exe not found."
    }
}

function Publish-ActOmegaEvent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$IntentTag
    )

    Set-Location $script:actOmegaHome
    if (Test-Path ".\topological_event_cascade.exe") {
        return & ".\topological_event_cascade.exe" $IntentTag *>&1 | Out-String
    } else {
        Write-Warning "topological_event_cascade.exe not found."
    }
}

function Test-ActOmegaSwarm {
    [CmdletBinding()]
    param()

    Set-Location $script:actOmegaHome
    if (Test-Path ".\topological_cluster_mesh.exe") {
        return & ".\topological_cluster_mesh.exe" *>&1 | Out-String
    } else {
        Write-Warning "topological_cluster_mesh.exe not found."
    }
}

function Get-ActOmegaTelemetry {
    [CmdletBinding()]
    param()

    Set-Location $script:actOmegaHome
    if (Test-Path ".\act_omega_autopoietic_daemon.exe") {
        return & ".\act_omega_autopoietic_daemon.exe" "1" *>&1 | Out-String
    } else {
        Write-Warning "act_omega_autopoietic_daemon.exe not found."
    }
}

# LAYER 2 DIRECTORY DISCOVERY, MANIFESTING & PULL ENGINE
function Get-ActOmegaDirectory {
    [CmdletBinding()]
    param(
        [ValidateSet("All", "Executables", "RustSource", "PowerShellScripts", "Manifest")]
        [string]$Category = "All",

        [string]$Filter = "*",

        [switch]$AsJson
    )

    Set-Location $script:actOmegaHome

    $dirItems = Get-ChildItem -Path $script:actOmegaHome -Filter $Filter -Recurse -File | Where-Object {
        if ($Category -eq "Executables") { $_.Extension -eq ".exe" }
        elseif ($Category -eq "RustSource") { $_.Extension -eq ".rs" }
        elseif ($Category -eq "PowerShellScripts") { $_.Extension -eq ".ps1" -or $_.Extension -eq ".psm1" -or $_.Extension -eq ".psd1" }
        elseif ($Category -eq "Manifest") { $_.Name -like "*manifest*" -or $_.Name -like "*USER_MANUAL*" -or $_.Name -like "*README*" }
        else { $true }
    }

    $subsystems = @()
    foreach ($item in $dirItems) {
        $subsystems += [PSCustomObject]@{
            Name          = $item.Name
            Extension     = $item.Extension
            SizeBytes     = $item.Length
            SizeKB        = [Math]::Round($item.Length / 1KB, 2)
            LastWriteTime = $item.LastWriteTime
            RelativePath  = $item.FullName.Replace($script:actOmegaHome, "").TrimStart("\")
            AbsolutePath  = $item.FullName
        }
    }

    $directoryManifest = [PSCustomObject]@{
        ActOmegaHome        = $script:actOmegaHome
        TotalSubsystemFiles = $subsystems.Count
        Timestamp           = (Get-Date).ToString("o")
        SharedMemoryTag     = "Global\ACT_OMEGA_E8_HYPER_MANIFOLD"
        ActivePorts         = @{
            TermuxBridge = 8088
            SpatialWeb   = 8090
            LLMProxy     = 8095
            SwarmMesh    = 8098
            RESTGateway  = 8099
        }
        SubsystemList       = $subsystems
    }

    if ($AsJson) {
        return ($directoryManifest | ConvertTo-Json -Depth 5)
    } else {
        return $directoryManifest
    }
}

function Export-ActOmegaManifest {
    [CmdletBinding()]
    param(
        [string]$OutputPath = "act_omega_directory_manifest.json"
    )

    Set-Location $script:actOmegaHome
    $manifestData = Get-ActOmegaDirectory -Category "All" -AsJson
    
    $targetFile = if ([System.IO.Path]::IsPathRooted($OutputPath)) { $OutputPath } else { Join-Path $script:actOmegaHome $OutputPath }
    Set-Content -Path $targetFile -Value $manifestData -Encoding utf8

    Write-Host "[+] ACT-Omega Workspace Directory Manifest Exported -> '$targetFile'" -ForegroundColor Green
    return $targetFile
}

function Sync-ActOmegaWorkspace {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$DestinationPath,

        [switch]$IncludeSource,

        [switch]$IncludeBinaries,

        [switch]$Force
    )

    if (-not (Test-Path $DestinationPath)) {
        Write-Host "[+] Creating target destination directory: '$DestinationPath'..." -ForegroundColor Yellow
        New-Item -ItemType Directory -Path $DestinationPath -Force | Out-Null
    }

    Set-Location $script:actOmegaHome

    $filesToSync = Get-ChildItem -Path $script:actOmegaHome -File | Where-Object {
        if ($IncludeBinaries -and $IncludeSource) { $true }
        elseif ($IncludeBinaries) { $_.Extension -eq ".exe" -or $_.Extension -eq ".psm1" -or $_.Extension -eq ".psd1" -or $_.Name -like "*.json" }
        elseif ($IncludeSource) { $_.Extension -eq ".rs" -or $_.Extension -eq ".ps1" -or $_.Extension -eq ".psm1" -or $_.Extension -eq ".psd1" }
        else { $_.Extension -eq ".psm1" -or $_.Extension -eq ".psd1" -or $_.Extension -eq ".exe" -or $_.Name -like "*.json" }
    }

    $copiedCount = 0
    foreach ($file in $filesToSync) {
        $destFile = Join-Path $DestinationPath $file.Name
        Copy-Item -Path $file.FullName -Destination $destFile -Force
        $copiedCount++
    }

    $manifestJson = Get-ActOmegaDirectory -AsJson
    Set-Content -Path (Join-Path $DestinationPath "act_omega_directory_manifest.json") -Value $manifestJson -Encoding utf8

    Write-Host "============================================================" -ForegroundColor DarkCyan
    Write-Host " [SUCCESS] ACT-Omega Workspace Pulled & Synced Successfully!" -ForegroundColor Green
    Write-Host " Destination Folder : $DestinationPath" -ForegroundColor Yellow
    Write-Host " Total Files Synced  : $copiedCount Files + Directory Manifest" -ForegroundColor Yellow
    Write-Host "============================================================" -ForegroundColor DarkCyan
}

Export-ModuleMember -Function `
    Invoke-ActOmegaQuery, `
    Get-ActOmegaSharedMemory, `
    Optimize-ActOmegaSystem, `
    Protect-ActOmegaMemory, `
    Publish-ActOmegaEvent, `
    Test-ActOmegaSwarm, `
    Get-ActOmegaTelemetry, `
    Get-ActOmegaDirectory, `
    Export-ActOmegaManifest, `
    Sync-ActOmegaWorkspace
