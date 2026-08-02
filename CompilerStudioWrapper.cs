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
