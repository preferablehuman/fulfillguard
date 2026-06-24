@echo off
set RUNLOG=run.log
set SPRINGLOG=spring.log
set FINALLOG=build.log

echo --- Run started at %date% %time% --- > %RUNLOG%
echo --- Spring Boot log started at %date% %time% --- > %SPRINGLOG%

echo [%date% %time%] Running mvnw clean verify... >> %RUNLOG%
call mvnw clean verify >> %RUNLOG% 2>&1

echo [%date% %time%] Starting Spring Boot application... >> %RUNLOG%
start /b mvnw spring-boot:run >> %SPRINGLOG% 2>&1

rem Give Spring Boot time to start
timeout /t 10 > nul

echo [%date% %time%] Checking health endpoint... >> %RUNLOG%
curl http://localhost:8080/actuator/health >> %RUNLOG% 2>&1

echo [%date% %time%] Killing Spring Boot process... >> %RUNLOG%
for /f "tokens=2" %%p in ('tasklist ^| findstr /i "java.exe"') do taskkill /f /pid %%p >> %RUNLOG% 2>&1

echo [%date% %time%] Merging logs... >> %RUNLOG%

rem Merge run.log + spring.log into final.log
(
    echo --- Combined Log Started at %date% %time% ---
    type %RUNLOG%
    echo.
    echo --- Spring Boot Output ---
    type %SPRINGLOG%
    echo --- Combined Log End ---
) > %FINALLOG%

echo [%date% %time%] Cleaning up temporary logs... >> %RUNLOG%
del %RUNLOG%
del %SPRINGLOG%

echo [%date% %time%] All tasks completed. Final log: %FINALLOG%
