Set-Location "C:\sovereign_manifold\santos-sync\topological_system_optimizer"

try { Stop-Process -Name "TopologicalPolyglotCompilerStudio" -Force -ErrorAction SilentlyContinue } catch {}

$cscPath = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe"

$csharpWrapper = @"
using System;
using System.Diagnostics;

namespace ACTOmegaCompilerStudio {
    class Program {
        [STAThread]
        static void Main(string[] args) {
            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "powershell.exe";
            psi.Arguments = "-sta -ExecutionPolicy Bypass -WindowStyle Hidden -File \".\\TopologicalPolyglotCompilerStudio.ps1\"";
            psi.UseShellExecute = false;
            Process.Start(psi);
        }
    }
}
"@

$wrapperSourcePath = ".\CompilerStudioWrapper.cs"
Set-Content -Path $wrapperSourcePath -Value $csharpWrapper -Encoding utf8

if (Test-Path $cscPath) {
    Write-Host "[+] Compiling Standalone Compiler Studio -> TopologicalPolyglotCompilerStudio.exe..." -ForegroundColor Green
    & $cscPath /target:winexe /out:".\TopologicalPolyglotCompilerStudio.exe" $wrapperSourcePath 2>&1 | Out-Null
    Write-Host "[+] TopologicalPolyglotCompilerStudio.exe Built Successfully!" -ForegroundColor Cyan
}
