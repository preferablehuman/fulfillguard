@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem Always run relative to the directory containing this script.
pushd "%~dp0" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not access script directory: %~dp0
    exit /b 90
)

rem ---------------------------------------------------------------------------
rem Configuration
rem ---------------------------------------------------------------------------
set "APP_PORT=8080"
set "HEALTH_URL=http://127.0.0.1:%APP_PORT%/actuator/health"
set "STARTUP_TIMEOUT_SECONDS=90"
set "POLL_INTERVAL_SECONDS=3"
set "MVNW=%CD%\mvnw.cmd"
set "APP_DIR=%CD%"
set "LOG_DIR=%CD%\logs"

rem ---------------------------------------------------------------------------
rem State
rem ---------------------------------------------------------------------------
set "EXIT_CODE=1"
set "APP_PID="
set "LISTENER_PID="
set "HEALTH_OK=0"

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not create log directory: "%LOG_DIR%"
    popd
    exit /b 91
)

for /f %%I in ('powershell.exe -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss" 2^>nul') do set "STAMP=%%I"
if not defined STAMP set "STAMP=%RANDOM%_%RANDOM%"

set "RUNLOG=%LOG_DIR%\run_%STAMP%.log"
set "SPRINGLOG=%LOG_DIR%\spring_%STAMP%.log"
set "FINALLOG=%LOG_DIR%\build_%STAMP%.log"
set "LATESTLOG=%LOG_DIR%\build-latest.log"
set "LAUNCHER=%TEMP%\spring-verify-%STAMP%-%RANDOM%.cmd"
set "HEALTH_RESPONSE=%TEMP%\spring-health-%STAMP%-%RANDOM%.txt"

> "%RUNLOG%" echo --- Verification started at %date% %time% ---
> "%SPRINGLOG%" echo --- Spring Boot output started at %date% %time% ---

call :log "Checking prerequisites..."

if not exist "%MVNW%" (
    call :log "ERROR: Maven Wrapper not found: %MVNW%"
    set "EXIT_CODE=10"
    goto :cleanup
)

where powershell.exe >nul 2>&1
if errorlevel 1 (
    call :log "ERROR: powershell.exe is required but was not found."
    set "EXIT_CODE=11"
    goto :cleanup
)

rem Reject an already occupied port. This prevents a different application from
rem producing a false-positive health result.
powershell.exe -NoProfile -Command "if (Get-NetTCPConnection -LocalPort %APP_PORT% -State Listen -ErrorAction SilentlyContinue) { exit 1 } else { exit 0 }" >nul 2>&1
if errorlevel 1 (
    call :log "ERROR: Port %APP_PORT% is already in use. The verification run was not started."
    netstat -ano | findstr ":%APP_PORT%" >> "%RUNLOG%" 2>&1
    set "EXIT_CODE=12"
    goto :cleanup
)

call :log "Running Maven clean verify..."
call "%MVNW%" -B clean verify >> "%RUNLOG%" 2>&1
set "BUILD_EXIT_CODE=!ERRORLEVEL!"

if not "!BUILD_EXIT_CODE!"=="0" (
    call :log "ERROR: Maven verification failed with exit code !BUILD_EXIT_CODE!."
    set "EXIT_CODE=!BUILD_EXIT_CODE!"
    if "!EXIT_CODE!"=="0" set "EXIT_CODE=20"
    goto :cleanup
)

call :log "Maven verification completed successfully."
call :log "Starting Spring Boot application..."

rem Use a small launcher file so that output ordering is retained in one log and
rem the spawned process tree can be terminated without killing unrelated Java apps.
> "%LAUNCHER%" (
    echo @echo off
    echo cd /d "%APP_DIR%"
    echo call "%MVNW%" -B spring-boot:run ^>^> "%SPRINGLOG%" 2^>^&1
    echo exit /b %%ERRORLEVEL%%
)

for /f "usebackq delims=" %%P in (`powershell.exe -NoProfile -Command "$a=@('/d','/c',([char]34+$env:LAUNCHER+[char]34));$p=Start-Process -FilePath $env:ComSpec -ArgumentList $a -WorkingDirectory $env:APP_DIR -WindowStyle Hidden -PassThru;$p.Id" 2^>^>"%RUNLOG%"`) do set "APP_PID=%%P"

if not defined APP_PID (
    call :log "ERROR: Spring Boot launcher process could not be started."
    set "EXIT_CODE=21"
    goto :cleanup
)

call :log "Spring Boot launcher PID: !APP_PID!"

set /a "ELAPSED_SECONDS=0"

:wait_for_health
call :check_health
if !ERRORLEVEL! equ 0 (
    set "HEALTH_OK=1"
    call :log "Health endpoint reported UP after !ELAPSED_SECONDS! seconds."
    >> "%RUNLOG%" echo Health response:
    type "%HEALTH_RESPONSE%" >> "%RUNLOG%" 2>&1
    goto :health_complete
)

rem Stop waiting early if the launcher process has already exited.
powershell.exe -NoProfile -Command "if (Get-Process -Id !APP_PID! -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }" >nul 2>&1
if errorlevel 1 (
    call :log "ERROR: Spring Boot launcher exited before the health endpoint became ready."
    if exist "%HEALTH_RESPONSE%" type "%HEALTH_RESPONSE%" >> "%RUNLOG%" 2>&1
    set "EXIT_CODE=22"
    goto :cleanup
)

if !ELAPSED_SECONDS! geq %STARTUP_TIMEOUT_SECONDS% (
    call :log "ERROR: Health endpoint did not report UP within %STARTUP_TIMEOUT_SECONDS% seconds."
    if exist "%HEALTH_RESPONSE%" (
        >> "%RUNLOG%" echo Last health-check response:
        type "%HEALTH_RESPONSE%" >> "%RUNLOG%" 2>&1
    )
    set "EXIT_CODE=23"
    goto :cleanup
)

timeout /t %POLL_INTERVAL_SECONDS% /nobreak >nul
set /a "ELAPSED_SECONDS+=POLL_INTERVAL_SECONDS"
goto :wait_for_health

:health_complete
for /f %%P in ('powershell.exe -NoProfile -Command "$c=Get-NetTCPConnection -LocalPort %APP_PORT% -State Listen -ErrorAction SilentlyContinue ^| Select-Object -First 1;if($c){$c.OwningProcess}" 2^>nul') do set "LISTENER_PID=%%P"
if defined LISTENER_PID call :log "Application listener PID: !LISTENER_PID!"

set "EXIT_CODE=0"
goto :cleanup

:cleanup
if defined APP_PID (
    call :log "Stopping the Spring Boot process tree for launcher PID !APP_PID!..."
    taskkill /PID !APP_PID! /T >> "%RUNLOG%" 2>&1
    timeout /t 2 /nobreak >nul

    powershell.exe -NoProfile -Command "if (Get-Process -Id !APP_PID! -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }" >nul 2>&1
    if not errorlevel 1 (
        call :log "Launcher process did not stop cleanly; forcing termination."
        taskkill /F /PID !APP_PID! /T >> "%RUNLOG%" 2>&1
    )
)

rem If Maven exited unexpectedly but the application listener survived, terminate
rem only the listener PID captured from the port owned by this verification run.
if defined LISTENER_PID (
    powershell.exe -NoProfile -Command "if (Get-Process -Id !LISTENER_PID! -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }" >nul 2>&1
    if not errorlevel 1 (
        call :log "Stopping remaining application listener PID !LISTENER_PID!..."
        taskkill /F /PID !LISTENER_PID! /T >> "%RUNLOG%" 2>&1
    )
)

if exist "%LAUNCHER%" del /q "%LAUNCHER%" >nul 2>&1
if exist "%HEALTH_RESPONSE%" del /q "%HEALTH_RESPONSE%" >nul 2>&1

if "%EXIT_CODE%"=="0" (
    call :log "Verification completed successfully."
) else (
    call :log "Verification failed with exit code %EXIT_CODE%."
)

call :log "Merging logs into %FINALLOG%"

(
    echo --- Combined verification log ---
    echo Generated: %date% %time%
    echo Exit code: %EXIT_CODE%
    echo.
    echo ===== Build and orchestration output =====
    type "%RUNLOG%"
    echo.
    echo ===== Spring Boot output =====
    type "%SPRINGLOG%"
    echo.
    echo --- End of combined verification log ---
) > "%FINALLOG%"

if errorlevel 1 (
    echo ERROR: Failed to create final log. Temporary logs were retained.
    set "EXIT_CODE=92"
    goto :finish
)

copy /y "%FINALLOG%" "%LATESTLOG%" >nul 2>&1

rem Remove temporary component logs only after the combined log was created.
del /q "%RUNLOG%" >nul 2>&1
del /q "%SPRINGLOG%" >nul 2>&1

:finish
echo.
if "%EXIT_CODE%"=="0" (
    echo SUCCESS: Build and health verification passed.
) else (
    echo FAILURE: Verification ended with exit code %EXIT_CODE%.
)
echo Final log: "%FINALLOG%"
echo Latest log: "%LATESTLOG%"

popd
endlocal & exit /b %EXIT_CODE%

:check_health
> "%HEALTH_RESPONSE%" powershell.exe -NoProfile -Command "$ErrorActionPreference='Stop';try{$r=Invoke-RestMethod -Uri $env:HEALTH_URL -TimeoutSec 5;$r ^| ConvertTo-Json -Compress -Depth 10;if($r.status -eq 'UP'){exit 0}else{exit 2}}catch{$_.Exception.Message;exit 1}"
exit /b %ERRORLEVEL%

:log
echo [%date% %time%] %~1
>> "%RUNLOG%" echo [%date% %time%] %~1
exit /b 0
