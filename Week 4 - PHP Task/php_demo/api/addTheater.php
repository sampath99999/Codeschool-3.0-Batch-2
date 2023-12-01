<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["theaterName"]) || !isset($_POST["location"])) {
    response("Theater name and location are required!");
}

$theaterName = $_POST["theaterName"];
$location = $_POST["location"];

$pdo = getPDO();

$query = "INSERT INTO theaters (theater_name, location) VALUES (:theaterName, :location)";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":theaterName", $theaterName, PDO::PARAM_STR);
$stmt->bindParam(":location", $location, PDO::PARAM_STR);

if ($stmt->execute()) {
    response("Theater added successfully", true);
} else {
    response("Failed to add theater", false);
}
