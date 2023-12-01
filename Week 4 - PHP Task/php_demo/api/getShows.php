<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

$pdo = getPDO();

$query = "SELECT * FROM shows";
$stmt = $pdo->prepare($query);
$stmt->execute();

$shows = $stmt->fetchAll(PDO::FETCH_ASSOC);

response("Shows data fetched successfully", true, $shows);
