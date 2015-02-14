@echo off
:: can open files with space paths but not in name

setlocal EnableDelayedExpansion

set PROGNAME=%~n0
set "ARGUMENTS="

for %%a in (%*) do (
    if exist %%a (
        for /f "delims=;" %%i in ('%CYGWIN_PATH%\bin\cygpath.exe -i -a %%a') do (
            echo %%a |>nul findstr \\\\ && (
                set temp=%%i
                call :append !temp:cygdrive/c=share! :: hack for share disks
            ) || (
                call :append %%i
            )
        )
    ) else (
        call :append %%a
    )
)
goto :on_start


:append
set TMPVAR=%ARGUMENTS%
set ARGUMENTS=%TEMPVAR% \"%*\"
goto :eof

:on_start

%CYGWIN_PATH%\bin\run.exe /bin/bash -l -c "'%PROGNAME% %ARGUMENTS%'"

