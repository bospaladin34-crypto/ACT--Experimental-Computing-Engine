@{
    RootModule = 'ActOmegaMesh.psm1'
    ModuleVersion = '25.0.0'
    GUID = 'e8250000-mesh-4672-9290-abcdef123456'
    Author = 'Donevin Frownfelter / ACT-Omega Core Team'
    CompanyName = 'Kalispell Concepts / ACT-Omega'
    Copyright = '(c) 2026 Kalispell Concepts / ACT-Omega. All rights reserved.'
    Description = 'ACT-Omega / Nephilim Compute Mesh v25.0 Module for WebRTC P2P Swarm, Deno Tasks, Native C-ABI SIMD & TensorVault Memory-Map.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @(
        'Start-ActOmegaMesh',
        'Stop-ActOmegaMesh',
        'Get-ActOmegaMeshStatus',
        'Invoke-ActOmegaDenoTask',
        'Start-ActOmegaSignalingServer',
        'Start-ActOmegaWorker',
        'Test-ActOmegaMasterE2E',
        'Test-ActOmegaSqliteVault',
        'Test-ActOmegaIntegratedVault',
        'Invoke-ActOmegaCernIngest',
        'Invoke-ActOmegaMaterialsIngest',
        'Invoke-ActOmegaCmbIngest',
        'Invoke-ActOmegaWikiIngest',
        'Invoke-ActOmegaFoldingEngine',
        'Invoke-ActOmegaDreamEngine',
        'Test-ActOmegaAdvancedExtensions',
        'Invoke-ActOmegaFullAudit'
    )
    CmdletsToExport = @()
    VariablesToExport = '*'
    AliasesToExport = @()
}
