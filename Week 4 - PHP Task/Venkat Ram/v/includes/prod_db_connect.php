<?php

function generate_PDO(){
    $username = "postgres";
    $password  = "venkatram";
    $host = "localhost";
    $dbname = "socialmedia";
    $dsn = "pgsql:host=$host;dbname=$dbname";
    
    try {
        $pdo = new PDO($dsn, $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
     
        return $pdo;
    } catch (Exception $e) {
        echo "Error Occured {$e->getMessage()}";
    }
}