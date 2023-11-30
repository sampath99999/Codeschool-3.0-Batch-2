<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["showId"])) {
    response("Show ID is required!");
}

$showId = $_POST["showId"];

$pdo = getPDO();

// Check if the show is running before deletion
$checkRunningQuery = "SELECT show_running FROM shows WHERE show_id = :showId";
$checkRunningStmt = $pdo->prepare($checkRunningQuery);
$checkRunningStmt->bindParam(":showId", $showId, PDO::PARAM_INT);
$checkRunningStmt->execute();

$showData = $checkRunningStmt->fetch(PDO::FETCH_ASSOC);

if (!$showData) {
    response("Show not found", false);
}

$showRunningStatus = $showData["show_running"];

if ($showRunningStatus === 'running') {
    response("Cannot delete a running show", false);
}

// If the show is not running, proceed with deletion
$deleteQuery = "DELETE FROM shows WHERE show_id = :showId";
$deleteStmt = $pdo->prepare($deleteQuery);
$deleteStmt->bindParam(":showId", $showId, PDO::PARAM_INT);

if ($deleteStmt->execute()) {
    response("Show deleted successfully", true);
} else {
    response("Failed to delete show", false);
}
