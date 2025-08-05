<?php
$sql = "SELECT * FROM general_payments WHERE Covered_Recipient_NPI = '1346204799' LIMIT 1 FORMAT JSON";
$endpoint = "http://clickhouse:8123/";

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $endpoint . "?query=" . urlencode($sql));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
if (curl_errno($ch)) {
    echo "cURL error: " . curl_error($ch) . "\n";
} else {
    echo "HTTP query executed successfully:\n";
    $httpResult = json_decode($response, true);
    if ($httpResult) {
        print_r($httpResult); 
    }
    else {
        echo "No results found for the HTTP query.\n";
    }
}