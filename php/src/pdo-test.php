<?php

$pdo=new PDO("mysql:host=clickhouse;port=9004;dbname=default", "default");

$sql = "SELECT * FROM general_payments WHERE Covered_Recipient_NPI = '1346204799' LIMIT 1";
$stmt = $pdo->prepare($sql);
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
if ($result) {
    echo "Query executed successfully:\n";
    print_r($result);
} else {
    echo "No results found for the query.\n";
}

