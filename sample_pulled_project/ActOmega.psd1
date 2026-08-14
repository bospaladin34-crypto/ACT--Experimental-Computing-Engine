@{
    RootModule = 'ActOmega.psm1'
    ModuleVersion = '25.0.0'
    GUID = 'fe880000-2500-4455-8899-abcdef012345'
    Author = 'Donevin Frownfelter / ACT-Omega Core Team'
    CompanyName = 'Kalispell Concepts / ACT-Omega'
    Copyright = '(c) 2026 Kalispell Concepts / ACT-Omega. All rights reserved.'
    Description = 'ACT-Omega v25.0 Universal PowerShell Integration Module for Topological Computing, E8 Shared Memory, Polyglot Code Synthesis, Event Cascades, and Workspace Directory Syncing.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @(
        'Invoke-ActOmegaQuery',
        'Get-ActOmegaSharedMemory',
        'Optimize-ActOmegaSystem',
        'Protect-ActOmegaMemory',
        'Publish-ActOmegaEvent',
        'Test-ActOmegaSwarm',
        'Get-ActOmegaTelemetry',
        'Get-ActOmegaDirectory',
        'Export-ActOmegaManifest',
        'Sync-ActOmegaWorkspace'
    )
    CmdletsToExport = @()
    VariablesToExport = '*'
    AliasesToExport = @()
}
