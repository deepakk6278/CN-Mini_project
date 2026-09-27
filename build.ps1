Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Building LAN Messenger (C++ / MinGW / Winsock2 / Win32)" -ForegroundColor Cyan
Write-Host "  Computer Networks Mini-Project" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

$SRC = "src"
$OUT = "build"
$EXE = "$OUT\lan_messenger.exe"

if (-not (Test-Path $OUT)) {
    New-Item -ItemType Directory -Path $OUT | Out-Null
}

Write-Host "[1/6] Compiling crypto.cpp..." -ForegroundColor Yellow
g++ -std=c++11 -c "$SRC/crypto.cpp" -o "$OUT/crypto.o"
if ($LASTEXITCODE -ne 0) { Write-Host "Build failed at crypto.cpp" -ForegroundColor Red; exit 1 }

Write-Host "[2/6] Compiling storage.cpp..." -ForegroundColor Yellow
g++ -std=c++11 -c "$SRC/storage.cpp" -o "$OUT/storage.o"
if ($LASTEXITCODE -ne 0) { Write-Host "Build failed at storage.cpp" -ForegroundColor Red; exit 1 }

Write-Host "[3/6] Compiling network_discovery.cpp..." -ForegroundColor Yellow
g++ -std=c++11 -c "$SRC/network_discovery.cpp" -o "$OUT/network_discovery.o"
if ($LASTEXITCODE -ne 0) { Write-Host "Build failed at network_discovery.cpp" -ForegroundColor Red; exit 1 }

Write-Host "[4/6] Compiling tcp_server.cpp..." -ForegroundColor Yellow
g++ -std=c++11 -c "$SRC/tcp_server.cpp" -o "$OUT/tcp_server.o"
if ($LASTEXITCODE -ne 0) { Write-Host "Build failed at tcp_server.cpp" -ForegroundColor Red; exit 1 }

Write-Host "[5/6] Compiling tcp_client.cpp & file_transfer.cpp..." -ForegroundColor Yellow
g++ -std=c++11 -c "$SRC/tcp_client.cpp" -o "$OUT/tcp_client.o"
if ($LASTEXITCODE -ne 0) { Write-Host "Build failed at tcp_client.cpp" -ForegroundColor Red; exit 1 }
g++ -std=c++11 -c "$SRC/file_transfer.cpp" -o "$OUT/file_transfer.o"
if ($LASTEXITCODE -ne 0) { Write-Host "Build failed at file_transfer.cpp" -ForegroundColor Red; exit 1 }

Write-Host "[6/6] Compiling main.cpp..." -ForegroundColor Yellow
g++ -std=c++11 -c "$SRC/main.cpp" -o "$OUT/main.o"
if ($LASTEXITCODE -ne 0) { Write-Host "Build failed at main.cpp" -ForegroundColor Red; exit 1 }

Write-Host ""
Write-Host "Linking all object files..." -ForegroundColor Cyan
g++ "$OUT/main.o" "$OUT/crypto.o" "$OUT/storage.o" "$OUT/network_discovery.o" "$OUT/tcp_server.o" "$OUT/tcp_client.o" "$OUT/file_transfer.o" -o "$EXE" -lws2_32 -lgdi32 -lcomctl32 -lcomdlg32 -mwindows -static
if ($LASTEXITCODE -ne 0) { Write-Host "Link failed!" -ForegroundColor Red; exit 1 }

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "  BUILD SUCCESSFUL!" -ForegroundColor Green
Write-Host "  Output: $EXE" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "To run:  .\build\lan_messenger.exe" -ForegroundColor White
Write-Host "Demo:    .\run_two_instances.bat" -ForegroundColor White
Write-Host ""
