# ============================================================================
# ACT-Ω Laptop Speaker Playback Helper
# Resolves Absolute .NET File Path & Plays 3D Spatial Binaural Audio
# ============================================================================

Set-Location "C:\sovereign_manifold\santos-sync\topological_system_optimizer"

$relativePath = ".\topological_spatial_binaural_15.965Hz.wav"

if (-not (Test-Path $relativePath)) {
    Write-Host "[+] Synthesizing 3D Spatial Audio WAV File..." -ForegroundColor Yellow
    if (Test-Path ".\topological_spatial_audio.exe") {
        & ".\topological_spatial_audio.exe" *>&1 | Out-Null
    }
}

if (Test-Path $relativePath) {
    $fullPath = (Get-Item $relativePath).FullName
    Write-Host "[+] Playing 3D Spatial Audio ($fullPath) via Laptop Speakers..." -ForegroundColor Green
    $player = New-Object System.Media.SoundPlayer($fullPath)
    $player.PlaySync()
    Write-Host "[+] Audio Playback Complete!" -ForegroundColor Cyan
} else {
    Write-Host "[!] Error: Audio synthesis file not found." -ForegroundColor Red
}
