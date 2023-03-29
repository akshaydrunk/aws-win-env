Write-Host "Sysmon"
$sysmonUrl = "https://download.sysinternals.com/files/Sysmon.zip"
$sysmonZip = "$env:TEMP\Sysmon.zip"
$sysmonPath = "C:\Sysmon"
$configUrl = "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml"
$configPath = "$sysmonPath\sysmonconfig.xml"
New-Item -ItemType Directory -Path $sysmonPath -Force | Out-Null
Invoke-WebRequest $sysmonUrl -OutFile $sysmonZip
Expand-Archive $sysmonZip -DestinationPath $sysmonPath
Remove-Item $sysmonZip
Invoke-WebRequest $configUrl -OutFile $configPath
& "$sysmonPath\sysmon.exe" -accepteula -i $configPath

Write-Host "`nDark Mode"
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value "0" -PropertyType "DWORD" -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value "0" -PropertyType "DWORD" -Force | Out-Null

Write-Host "`nNotepad++"
$url = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5/npp.8.5.Installer.exe"
$filePath = "$env:TEMP\npp.8.5.Installer.exe"
Invoke-WebRequest -Uri $url -OutFile $filePath
$arguments = "/S"
Start-Process -FilePath $filePath -ArgumentList $arguments -Wait
Remove-Item $filePath

Write-Host  "`nWindows terminal"
$url = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
$outfile = "$env:TEMP\Microsoft.VCLibs.x64.14.00.Desktop.appx"
Invoke-WebRequest -Uri $url -OutFile $outfile
Add-AppxPackage $outfile
Remove-Item $outfile
$url = "https://github.com/microsoft/terminal/releases/download/v1.16.10261.0/Microsoft.WindowsTerminal_Win10_1.16.10261.0_8wekyb3d8bbwe.msixbundle"
$outfile = "$env:TEMP\Microsoft.WindowsTerminal_Win11_1.16.10262.0_8wekyb3d8bbwe.msixbundle"
Invoke-WebRequest -Uri $url -OutFile $outfile
Add-AppxPackage $outfile
Remove-Item $outfile
