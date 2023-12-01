<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

$pdo = getPDO();

$query = "SELECT * FROM bookings";
$stmt = $pdo->prepare($query);
$stmt->execute();

$bookings = $stmt->fetchAll(PDO::FETCH_ASSOC);

response("Bookings data fetched successfully", true, $bookings);