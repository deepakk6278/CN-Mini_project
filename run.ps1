Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  LAN Messenger Demo - Launching Two Instances" -ForegroundColor Cyan
Write-Host "  Computer Networks Mini-Project" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Ensure accounts exist
if (Test-Path "build\seed_accounts.exe") {
    & ".\build\seed_accounts.exe" | Out-Null
}

Write-Host "Starting Instance 1: Alice (Port 50001)..." -ForegroundColor Green
Start-Process ".\build\lan_messenger.exe"

Start-Sleep -Seconds 2

Write-Host "Starting Instance 2: Bob (Port 50002)..." -ForegroundColor Green
Start-Process ".\build\lan_messenger.exe"

Write-Host ""
Write-Host "Both instances launched!" -ForegroundColor Cyan
Write-Host ""
Write-Host "Login Credentials:" -ForegroundColor Yellow
Write-Host "  Instance 1: Username = alice | Password = alice123 | Port = 50001" -ForegroundColor White
Write-Host "  Instance 2: Username = bob   | Password = bob123   | Port = 50002" -ForegroundColor White
Write-Host ""
Write-Host "Wait 3-5 seconds for automatic UDP peer discovery (port 50005)!" -ForegroundColor Magenta
