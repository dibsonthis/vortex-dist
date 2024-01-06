@echo off

:: Function to update the project
:update

    :: Download and unzip interpreter and modules
    curl -LO -k "https://github.com/dibsonthis/Vortex/releases/latest/download/windows.zip"

    powershell Expand-Archive "windows.zip" "windows"

    if exist modules (
        rmdir /s /q modules
        echo Deleting modules...
    ) else (
        echo.
    )

    if exist vortex.exe (
        echo Deleting interpreter...
        del vortex.exe
    ) else (
        echo.
    )

    move windows\vortex.exe vortex.exe

    if exist modules.txt (
        echo.
    ) else (
        echo functional> modules.txt
        echo functools>> modules.txt
        echo future>> modules.txt
        echo io>> modules.txt
        echo json>> modules.txt
        echo logging>> modules.txt
        echo math>> modules.txt
        echo os>> modules.txt
        echo requests>> modules.txt
        echo sdl>> modules.txt
        echo string>> modules.txt
        echo sys>> modules.txt
        echo time>> modules.txt
    )

    mkdir modules
    cd modules

    for /f "usebackq delims=" %%a in ("..\modules.txt") do (
        set "trimmed=%%a"
        setlocal enabledelayedexpansion
        move "..\windows\modules\!trimmed!" "!trimmed!"
    )

    cd ..

    rmdir /s /q windows
    del windows.zip
    del "update.bat"

goto :eof

:: Call the update function
call :update
