using System;
using System.Diagnostics;

namespace ACTOmegaStudio {
    class Program {
        static void Main(string[] args) {
            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "powershell.exe";
            psi.Arguments = "-ExecutionPolicy Bypass -WindowStyle Hidden -File \".\\TopologicalMasterStudio.ps1\"";
            psi.UseShellExecute = false;
            Process.Start(psi);
        }
    }
}
