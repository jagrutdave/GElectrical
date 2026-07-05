@echo off
REM Launch GElectrical under the MSYS2 mingw64 Python (required for GTK3/PyGObject).
REM Double-click this file, or run "run.bat" from a command prompt.

set "MINGW=C:\msys64\mingw64\bin"
set "PYEXE=%MINGW%\python.exe"

if not exist "%PYEXE%" (
    echo MSYS2 mingw64 Python not found at "%PYEXE%".
    echo Install MSYS2 and the GTK3 stack first.
    pause
    exit /b 1
)

REM GTK DLLs and helper tools must be on PATH.
set "PATH=%MINGW%;C:\msys64\usr\bin;%PATH%"

REM Run from the folder this script lives in.
cd /d "%~dp0"

"%PYEXE%" gelectrical_launcher.py %*
exit /b %ERRORLEVEL%
