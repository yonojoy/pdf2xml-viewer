if "%~1" == "" goto hlp

SET TOOL_DIR=C:\GitHubProjects\pdf2xml-viewer\

SET TEMP_DIR=%TEMP%\pdf2xml-temp\

if not exist "%TOOL_DIR%" SET TOOL_DIR=C:\Projekte\GitHub\pdf2xml-viewer\
if not exist "%TOOL_DIR%" SET TOOL_DIR=%~dp0
xcopy "%TOOL_DIR%" "%TEMP_DIR%" /y

copy "%~1" "%TEMP_DIR%Temp.xml"

cd "%TEMP_DIR%"
start cmd.exe @cmd /k "echo Running webserver in "%TEMP_DIR%" & cd "%TEMP_DIR%" & python -m SimpleHTTPServer 8080"
REM Alternative: python3 -m http.server 8080 --bind 127.0.0.1

echo Waiting for web service to start
timeout /t 2
start chrome http://localhost:8080/index.html

@color 2F
@echo off
echo To finish close the browser window and the black cmd window with the web server running, than press a key.
pause
rmdir "%TEMP_DIR%"

:end
Exit

:hlp
echo run pdf2xml-viewer.bat a_pdf2xml_file_to_display.xml
