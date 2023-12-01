<?php
$host = "localhost";
$dbname = "socialmedias";
$dsn = "pgsql:host=$host;dbname=$dbname";
$dbusername = "postgres";
$dbpassword = "postgres";


try {
    $pdo = new PDO($dsn, $dbusername, $dbpassword);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    // echo "successfully connected..... to database ✅";
} catch (Exception $e) {
    echo "Connection failed ...." . $e->getMessage();
}
