# ============================================================================
# ACT-Ω Master Executable Compiler Harness
# Compiles TopologicalMasterStudio.ps1 -> Standalone TopologicalMasterStudio.exe
# Forces STA Thread Mode (-sta) for 100% WinForms Stability
# ============================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Set-Location "C:\sovereign_manifold\santos-sync\topological_system_optimizer"

Write-Host "============================================================" -ForegroundColor DarkCyan
Write-Host " [ACT-Ω v25.0] Compiling Master Studio into Standalone EXE " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor DarkCyan

$cscPath = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe"

$csharpWrapper = @"
using System;
using System.Diagnostics;

namespace ACTOmegaStudio {
    class Program {
        [STAThread]
        static void Main(string[] args) {
            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "powershell.exe";
            psi.Arguments = "-sta -ExecutionPolicy Bypass -WindowStyle Hidden -File \".\\TopologicalMasterStudio.ps1\"";
            psi.UseShellExecute = false;
            Process.Start(psi);
        }
    }
}
"@

$wrapperSourcePath = ".\MasterExeWrapper.cs"
Set-Content -Path $wrapperSourcePath -Value $csharpWrapper -Encoding utf8

if (Test-Path $cscPath) {
    Write-Host "[+] Compiling C# Host Wrapper -> TopologicalMasterStudio.exe..." -ForegroundColor Green
    & $cscPath /target:winexe /out:".\TopologicalMasterStudio.exe" $wrapperSourcePath 2>&1 | Out-Null
    
    if (Test-Path ".\TopologicalMasterStudio.exe") {
        Write-Host "============================================================" -ForegroundColor DarkCyan
        Write-Host " [SUCCESS] Standalone Executable Created: TopologicalMasterStudio.exe" -ForegroundColor Green
        Write-Host " Double-click TopologicalMasterStudio.exe to launch the entire suite!" -ForegroundColor Yellow
        Write-Host "============================================================" -ForegroundColor DarkCyan
    }
}
