<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (
    !isset($_POST["showId"]) ||
    !isset($_POST["userId"]) ||
    !isset($_POST["bookedSeats"])
) {
    response("Show ID, User ID, and Booked Seats are required!");
}

$showId = $_POST["showId"];
$userId = $_POST["userId"];
$bookedSeats = $_POST["bookedSeats"];

$pdo = getPDO();
$query = "SELECT show_running FROM shows WHERE show_id = :showId";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":showId", $showId, PDO::PARAM_INT);
$stmt->execute();
$showRunning = $stmt->fetchColumn();

if ($showRunning === 'running') {
    response("Cannot book seats for a show that is currently running!");
}
$query = "INSERT INTO bookings (show_id, user_id, booked_seats) 
          VALUES (:showId, :userId, :bookedSeats)";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":showId", $showId, PDO::PARAM_INT);
$stmt->bindParam(":userId", $userId, PDO::PARAM_INT);
$stmt->bindParam(":bookedSeats", $bookedSeats, PDO::PARAM_INT);

if ($stmt->execute()) {
    response("Booking added successfully", true);
} else {
    response("Failed to add booking", false);
}
