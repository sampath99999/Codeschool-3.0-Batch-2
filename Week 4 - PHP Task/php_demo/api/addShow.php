<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (
    !isset($_POST["theaterId"]) ||
    !isset($_POST["movieName"]) ||
    !isset($_POST["showRunning"])
) {
    response("Theater ID, movie name, show time, and show running status are required!");
}

$theaterId = $_POST["theaterId"];
$movieName = $_POST["movieName"];
$showRunning = $_POST["showRunning"];

$pdo = getPDO();

$query = "INSERT INTO shows (theater_id, movie_name, show_running) VALUES (:theaterId, :movieName, :showRunning)";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":theaterId", $theaterId, PDO::PARAM_INT);
$stmt->bindParam(":movieName", $movieName, PDO::PARAM_STR);
$stmt->bindParam(":showRunning", $showRunning, PDO::PARAM_STR);

if ($stmt->execute()) {
    response("Show added successfully", true);
} else {
    response("Failed to add show", false);
}
