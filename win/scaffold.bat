@echo off

:: Function to scaffold the project
:scaffold
    mkdir modules
    mkdir src

    echo.import time > "src/main.vtx"
    echo.import [] : string >> "src/main.vtx"
    echo.import [] : functional >> "src/main.vtx"
    echo. >> "src/main.vtx"
    echo.const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"] >> "src/main.vtx"
    echo. >> "src/main.vtx"
    echo.const datetime = time.datetime() >> "src/main.vtx"
    echo.const datetime_split = datetime.split().filter^(^(e^) =^> e != ""^) >> "src/main.vtx"
    echo.const datetime_obj = {^ >> "src/main.vtx"
    echo.    dayname: datetime_split[0],^ >> "src/main.vtx"
    echo.    monthname: datetime_split[1],^ >> "src/main.vtx"
    echo.    day: datetime_split[2],^ >> "src/main.vtx"
    echo.    month: months.indexOf(datetime_split[1]) + 1,^ >> "src/main.vtx"
    echo.    year: datetime_split[4],^ >> "src/main.vtx"
    echo.    time: datetime_split[3],^ >> "src/main.vtx"
    echo.} >> "src/main.vtx"
    echo. >> "src/main.vtx"
    echo.println(datetime_obj) >> "src/main.vtx"

    echo.# Ignore interpreter and modules dir > ".gitignore"
    echo.vortex >> ".gitignore"
    echo.modules/ >> ".gitignore"
    echo..DS_Store >> ".gitignore"

    echo.; Vortex Configuration > "config.ini"
    echo.>> "config.ini"
    echo.; entry: Sets the entry point of the program from root >> "config.ini"
    echo.; modules: Sets the modules folder - leave as an empty string to use system installed modules >> "config.ini"
    echo.>> "config.ini"
    echo.entry="src/main.vtx">> "config.ini"
    echo.modules="modules">> "config.ini"

    echo.@echo off > "run.bat"
    echo.setlocal enabledelayedexpansion >> "run.bat"
    echo. >> "run.bat"
    echo.rem Load config.ini values >> "run.bat"
    echo.for /f "usebackq tokens=1,* delims==" %%%%i in ("config.ini") do (^ >> "run.bat"
    echo.    set "%%%%i=%%%%~j"^ >> "run.bat"
    echo.) >> "run.bat"
    echo. >> "run.bat"
    echo.if not defined modules (^ >> "run.bat"
    echo.    vortex.exe !entry!^ >> "run.bat"
    echo.) else (^ >> "run.bat"
    echo.    vortex.exe !entry! -m !CD!\!modules!^ >> "run.bat"
    echo.) >> "run.bat"
    echo. >> "run.bat"
    echo.endlocal >> "run.bat"

    :: Download and unzip interpreter and modules
    curl -LO -k "https://github.com/dibsonthis/Vortex/releases/latest/download/windows.zip"

    powershell Expand-Archive "windows.zip" "windows"

    move "windows\vortex.exe" "vortex.exe"

    if not exist "modules.txt" (
        (
            echo.functional
            echo.functools
            echo.future
            echo.io
            echo.json
            echo.logging
            echo.math
            echo.os
            echo.requests
            echo.sdl
            echo.string
            echo.sys
            echo.time
            echo.random
            echo.sqlite
        ) > "modules.txt"
    )

    cd modules
    for /f "usebackq delims=" %%a in ("..\modules.txt") do (
        set "trimmed=%%a"
        setlocal enabledelayedexpansion
        move "..\windows\modules\!trimmed!" "!trimmed!"
    )
    cd ..

    rmdir /s /q "windows"
    del /q "windows.zip"
    del "scaffold.bat"
goto :eof

:: Call the scaffold function
call :scaffold
