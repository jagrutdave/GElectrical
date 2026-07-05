# Launch GElectrical under the MSYS2 mingw64 Python (required for GTK3/PyGObject).
# Usage:  right-click > Run with PowerShell, or from a prompt:  .\run.ps1
$ErrorActionPreference = "Stop"

$mingw = "C:\msys64\mingw64\bin"
$py    = Join-Path $mingw "python.exe"

if (-not (Test-Path $py)) {
    Write-Error "MSYS2 mingw64 Python not found at $py. Install MSYS2 and the GTK3 stack first."
    exit 1
}

# GTK DLLs and helper tools must be on PATH.
$env:Path = "$mingw;C:\msys64\usr\bin;$env:Path"

# Run from this script's directory so imports resolve.
Set-Location -Path $PSScriptRoot

& $py "gelectrical_launcher.py" @args
exit $LASTEXITCODE
