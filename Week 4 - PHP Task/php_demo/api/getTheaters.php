<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

$pdo = getPDO();

$query = "SELECT * FROM theaters";
$stmt = $pdo->prepare($query);
$stmt->execute();

$theaters = $stmt->fetchAll(PDO::FETCH_ASSOC);

response("Theaters data fetched successfully", true, $theaters);
