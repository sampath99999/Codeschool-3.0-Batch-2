<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["bookingId"])) {
    response("Booking ID is required!");
}

$bookingId = $_POST["bookingId"];

$pdo = getPDO();

// Check if the booking can be deleted
$query = "SELECT show_running FROM shows
          INNER JOIN bookings ON shows.show_id = bookings.show_id
          WHERE bookings.booking_id = :bookingId";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":bookingId", $bookingId, PDO::PARAM_INT);
$stmt->execute();
$showRunning = $stmt->fetchColumn();

if ($showRunning === 'running') {
    response("Cannot delete a booking for a show that is currently running!");
}

// Delete the booking
$query = "DELETE FROM bookings WHERE booking_id = :bookingId";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":bookingId", $bookingId, PDO::PARAM_INT);

try {
    $stmt->execute();
    response("Booking deleted successfully", true);
} catch (PDOException $e) {
    response("Failed to delete booking. " . $e->getMessage(), false);
}
