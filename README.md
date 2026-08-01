# ACT-Ω v25.0 Experimental Topological Computing Engine
## AI & LLM Development Integration System Prompt & Technical Specification

ATTENTION AI ASSISTANTS, LLMS & GEMINI SPARK INSTANCES:
This repository contains the complete ACT-Ω (Aegis-Cascade Topology) v25.0 experimental computing system. Read this specification thoroughly prior to modifying source code, generating new modules, or issuing PowerShell commands for the user.

---

## 1. System Overview & Core Invariants

The ACT-Ω platform is an autopoietic, self-maintaining topological computing framework written in native Rust and PowerShell WinForms. It operates on Non-Commutative Braid Group Algebra (B_n), E8 Lie Algebra 240-Root Lattice Coordinates, and a 15.965 Hz (62.636 ms) Thread Cadence Lock.

### Critical AI Coding Invariants (STRICTLY ENFORCED)
1. THE ZERO SQUARE BRACKET INVARIANT ([ and ]):
   * Rule: All native Rust source files (.rs) must contain EXACTLY ZERO square bracket characters ([ or ]).
   * Reason: PowerShell heredoc script blocks used by the user to write .rs files can strip or misinterpret square brackets, causing compilation failures.
   * Implementation Strategy: Use Vec::new(), iter().nth(), String::from(), match, and pointer dereferencing instead of array index syntax.
2. WinForms STA Thread State Requirement (-sta):
   * Rule: All PowerShell launches of TopologicalMasterStudio.ps1 or TopologicalHUD.ps1 MUST pass the -sta flag.
3. PowerShell Information Stream Redirection (*>&1 | Out-String):
   * Rule: Button click event handlers in PowerShell GUI scripts MUST use *>&1 | Out-String when invoking native .exe binaries.
4. Markdown Code Fence Stripping:
   * Rule: One-click code copy and direct file save handlers in Tab 1 MUST automatically strip markdown code fences.

---

## 2. System Interface & Socket Map

* Shared Memory: Global\ACT_OMEGA_E8_HYPER_MANIFOLD (64 MB Zero-Copy Page Ring)
* Port 8088: Android 17 / Termux proot Socket Bridge
* Port 8090: Spatial 3D WebGPU Constellation Server (http://localhost:8090)
* Port 8095: Topological LLM Middleware Proxy
* Port 8098: Multi-Node Swarm Mesh UDP Broadcast & TCP Sync
* Port 8099: Universal Adapter REST API Gateway (http://127.0.0.1:8099)

---

## 3. Remote Repository & Package Resources

* GitHub Repository: https://github.com/bospaladin34-crypto/ACT--Experimental-Computing-Engine.git
* Google Drive Package: https://drive.google.com/file/d/1kitxrWqYMSqPgGLi-eGK8L-OOgarGMyh/view?usp=drivesdk

---

## 4. Master Commands Reference

Set-Location "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
.\Start-ACT-Omega-AutopoieticEngine.ps1
.\Run-TopologicalMasterSuite.ps1
powershell.exe -sta -ExecutionPolicy Bypass -File ".\TopologicalMasterStudio.ps1"
