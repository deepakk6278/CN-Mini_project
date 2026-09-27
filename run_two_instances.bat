@echo off
title LAN Messenger - Demo Launcher
echo ================================================
echo   LAN Messenger Demo - Two Instances
echo   Computer Networks Mini-Project
echo ================================================
echo.

REM First, seed two test accounts if they don't exist
echo Seeding demo accounts (alice / bob)...
build\lan_messenger.exe --seed-accounts 2>nul

echo Starting Instance 1: Alice (Port 50001)...
start "Alice - LAN Messenger" build\lan_messenger.exe

echo Starting Instance 2: Bob (Port 50002)...
timeout /t 2 /nobreak > nul
start "Bob - LAN Messenger" build\lan_messenger.exe

echo.
echo Both instances launched!
echo.
echo Login Credentials:
echo   Instance 1: Username=alice  Password=alice123  Port=50001
echo   Instance 2: Username=bob    Password=bob123    Port=50002
echo.
echo Features to demonstrate:
echo   1. Register/Login with salted password hashing
echo   2. Auto-discovery via UDP broadcast (port 50005)
echo   3. One-to-one encrypted TCP messaging
echo   4. Group chat (multi-unicast)
echo   5. LAN broadcast announcements
echo   6. File sharing with SHA-256 verification
echo   7. Wire Packet Inspector (shows encrypted payloads)
echo   8. CN Diagnostics panel
echo.
pause
