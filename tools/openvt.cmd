@echo off

rem openvt - launch the vtterm binary
rem Runs the VtPipeTerm.exe binary generated by the build in the debug directory.
rem    Passes any args along.

setlocal
set _last_build=%OPENCON%\bin\%ARCH%\%_LAST_BUILD_CONF%

if not exist %_last_build%\VtPipeTerm.exe (
    echo Could not locate the VtPipeTerm.exe in %_last_build%. Double check that it has been built and try again.
    goto :eof
)

set _r=%random%
set copy_dir=OpenConsole\%_r%
rem Generate a unique name, so that we can debug multiple revisions of the binary at the same time if needed.

(echo f | xcopy /Y %_last_build%\OpenConsole.exe %TEMP%\%copy_dir%\conhost.exe) > nul
(echo f | xcopy /Y %_last_build%\console.dll %TEMP%\%copy_dir%\console.dll) > nul
(echo f | xcopy /Y %_last_build%\VtPipeTerm.exe %TEMP%\%copy_dir%\VtPipeTerm.exe) > nul
(echo f | xcopy /Y %_last_build%\Nihilist.exe %TEMP%\%copy_dir%\Nihilist.exe) > nul

start %TEMP%\%copy_dir%\conhost.exe %TEMP%\%copy_dir%\VtPipeTerm.exe %*
echo Launching %TEMP%\%copy_dir%\VtPipeTerm.exe...
