@echo off
title LAN Messenger - C++ Build Script
echo ============================================================
echo   Building LAN Messenger (C++ / MinGW / Winsock2 / Win32)
echo   Computer Networks Mini-Project
echo ============================================================
echo.

set SRC=src
set OUT=build
set EXE=%OUT%\lan_messenger.exe

if not exist %OUT% mkdir %OUT%

echo [1/6] Compiling crypto.cpp...
g++ -std=c++11 -c %SRC%/crypto.cpp -o %OUT%/crypto.o
if errorlevel 1 goto :fail

echo [2/6] Compiling storage.cpp...
g++ -std=c++11 -c %SRC%/storage.cpp -o %OUT%/storage.o
if errorlevel 1 goto :fail

echo [3/6] Compiling network_discovery.cpp...
g++ -std=c++11 -c %SRC%/network_discovery.cpp -o %OUT%/network_discovery.o
if errorlevel 1 goto :fail

echo [4/6] Compiling tcp_server.cpp...
g++ -std=c++11 -c %SRC%/tcp_server.cpp -o %OUT%/tcp_server.o
if errorlevel 1 goto :fail

echo [5/6] Compiling tcp_client.cpp + file_transfer.cpp...
g++ -std=c++11 -c %SRC%/tcp_client.cpp -o %OUT%/tcp_client.o
if errorlevel 1 goto :fail
g++ -std=c++11 -c %SRC%/file_transfer.cpp -o %OUT%/file_transfer.o
if errorlevel 1 goto :fail

echo [6/6] Compiling main.cpp and linking...
g++ -std=c++11 -c %SRC%/main.cpp -o %OUT%/main.o
if errorlevel 1 goto :fail

echo.
echo Linking all object files...
g++ %OUT%/main.o %OUT%/crypto.o %OUT%/storage.o %OUT%/network_discovery.o %OUT%/tcp_server.o %OUT%/tcp_client.o %OUT%/file_transfer.o -o %EXE% -lws2_32 -lgdi32 -lcomctl32 -lcomdlg32 -mwindows -static
if errorlevel 1 goto :fail

echo.
echo ============================================================
echo   BUILD SUCCESSFUL!
echo   Output: %EXE%
echo ============================================================
echo.
echo To run:  %EXE%
echo Demo:    run_two_instances.bat
echo.
goto :end

:fail
echo.
echo ============================================================
echo   BUILD FAILED! Check the errors above.
echo ============================================================

:end
pause
