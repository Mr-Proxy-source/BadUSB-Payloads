# $url = "https://example.link/file.exe"
# $extension = "exe"
$output = "C:\temp\file.$extension"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $output

# Run the downloaded file
Start-Process -FilePath $output -Wait


# Exit the script
exit
