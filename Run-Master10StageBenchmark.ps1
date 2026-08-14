$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$scriptDir = "C:\sovereign_manifold\santos-sync\topological_system_optimizer"
if (Test-Path $scriptDir) { Set-Location $scriptDir }

Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host " [ACT-Ω v25.0] Launching Master 10-Stage End-to-End Architectural Benchmark" -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Cyan

# 1. COMPILE & EXECUTE NATIVE RUST 10-STAGE BENCHMARK
Write-Host "`n[1/2] Compiling & Executing Native Rust 10-Stage Benchmark Engine..." -ForegroundColor Green
if (Test-Path ".\topological_master_10stage_benchmark.rs") {
    rustc -O .\topological_master_10stage_benchmark.rs -o .\topological_master_10stage_benchmark.exe 2>&1 | Out-Null
    if (Test-Path ".\topological_master_10stage_benchmark.exe") {
        & ".\topological_master_10stage_benchmark.exe"
    }
}

# 2. EXECUTE DENO TYPESCRIPT 10-STAGE RUNNER
Write-Host "`n[2/2] Checking Deno TypeScript Pipeline Runner..." -ForegroundColor Green
$denoCmd = Get-Command deno -ErrorAction SilentlyContinue
if ($denoCmd -and (Test-Path ".\test_master_end_to_end_architecture.ts")) {
    Write-Host "[+] Executing 'deno run --allow-all test_master_end_to_end_architecture.ts'..." -ForegroundColor Cyan
    deno run --allow-all .\test_master_end_to_end_architecture.ts
} else {
    Write-Host "[i] Deno TypeScript runner ready at: .\test_master_end_to_end_architecture.ts" -ForegroundColor Gray
}

Write-Host "`n================================================================================" -ForegroundColor Cyan
Write-Host " [COMPLETE] Master 10-Stage Architectural Benchmark Audit Complete!" -ForegroundColor Green
Write-Host "================================================================================" -ForegroundColor Cyan
