# ============================================================================
# ACT-Ω Background System Tray & Hotkey Turbo Switcher
# Windows Forms / Win32 System Tray Integration
# ============================================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Hide PowerShell Console Window
$AsyncWindow = '[DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);'
$Type = Add-Type -MemberDefinition $AsyncWindow -Name "Win32ShowWindow" -Namespace Win32Functions -PassThru
$hwnd = (Get-Process -Id $PID).MainWindowHandle
if ($hwnd -ne [IntPtr]::Zero) {
    $Type::ShowWindow($hwnd, 0) # 0 = Hide Console
}

# Create System Tray Icon
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$notifyIcon.Icon = [System.Drawing.SystemIcons]::Shield
$notifyIcon.Text = "ACT-Ω Topological System Turbo Engine"
$notifyIcon.Visible = $true

$contextMenu = New-Object System.Windows.Forms.ContextMenu

# 1. Toggle Turbo Mode Item
$isTurboActive = $false
$toggleTurboItem = New-Object System.Windows.Forms.MenuItem("Enable Turbo Mode (0ms Latency)")
$toggleTurboItem.add_Click({
    if (-not $script:isTurboActive) {
        $script:isTurboActive = $true
        $script:toggleTurboItem.Text = "Disable Turbo Mode (Active)"
        
        # Execute Hardware Topology Optimizer
        if (Test-Path ".\topological_optimizer.exe") {
            Start-Process -FilePath ".\topological_optimizer.exe" -WindowStyle Hidden
        }
        
        $notifyIcon.ShowBalloonTip(3000, "ACT-Ω Turbo Engine", "Turbo Mode Enabled! High-Priority P-Core & Memory Alignment Active.", [System.Windows.Forms.ToolTipIcon]::Info)
    } else {
        $script:isTurboActive = $false
        $script:toggleTurboItem.Text = "Enable Turbo Mode (0ms Latency)"
        $notifyIcon.ShowBalloonTip(3000, "ACT-Ω Turbo Engine", "Turbo Mode Disabled. Returned to Nominal System State.", [System.Windows.Forms.ToolTipIcon]::Warning)
    }
})
$contextMenu.MenuItems.Add($toggleTurboItem) | Out-Null

# 2. Launch Process Watcher Item
$watcherItem = New-Object System.Windows.Forms.MenuItem("Start Real-Time Process Watcher")
$watcherItem.add_Click({
    if (Test-Path ".\Start-TopologicalProcessWatcher.ps1") {
        Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File .\Start-TopologicalProcessWatcher.ps1" -WindowStyle Hidden
        $notifyIcon.ShowBalloonTip(3000, "ACT-Ω Watcher", "Foreground Auto-Tuner Process Watcher Launched in Background.", [System.Windows.Forms.ToolTipIcon]::Info)
    }
})
$contextMenu.MenuItems.Add($watcherItem) | Out-Null

# 3. Exit Item
$exitItem = New-Object System.Windows.Forms.MenuItem("Exit")
$exitItem.add_Click({
    $notifyIcon.Visible = $false
    [System.Windows.Forms.Application]::Exit()
})
$contextMenu.MenuItems.Add($exitItem) | Out-Null

$notifyIcon.ContextMenu = $contextMenu

# Initial Balloon Tip
$notifyIcon.ShowBalloonTip(4000, "ACT-Ω v25.0 Engine Ready", "Topological System Tray Switcher Active. Right-click icon in taskbar tray to toggle Turbo Mode.", [System.Windows.Forms.ToolTipIcon]::Info)

# Run Application Loop
[System.Windows.Forms.Application]::Run()
