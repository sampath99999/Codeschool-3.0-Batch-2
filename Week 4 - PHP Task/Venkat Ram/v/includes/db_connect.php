<?php
$host = "localhost";
$dbname = "socialmedia";
$dsn = "pgsql:host=$host;dbname=$dbname";
$dbusername = "postgres";
$dbpassword = "venkatram";


try {
    $pdo = new PDO($dsn, $dbusername, $dbpassword);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

} catch (Exception $e) {
    echo "Error Occurred {$e->getMessage()}";
}
