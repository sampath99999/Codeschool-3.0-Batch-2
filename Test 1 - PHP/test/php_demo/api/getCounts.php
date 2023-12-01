<?php
include("./utils/cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");

// Check for token or authentication if needed

// Connect to the database
$pdo = getPDO();

// Count of Active Users
$queryActive = "SELECT COUNT(*) AS active_count FROM employee WHERE status = 'active'";
$stmtActive = $pdo->query($queryActive);
$resultActive = $stmtActive->fetch(PDO::FETCH_ASSOC);
$activeCount = $resultActive['active_count'];

// Count of Inactive Users
$queryInactive = "SELECT COUNT(*) AS inactive_count FROM employee WHERE status = 'inactive'";
$stmtInactive = $pdo->query($queryInactive);
$resultInactive = $stmtInactive->fetch(PDO::FETCH_ASSOC);
$inactiveCount = $resultInactive['inactive_count'];

// Return the counts as JSON
$response = [
    'activeCount' => $activeCount,
    'inactiveCount' => $inactiveCount,
];

echo json_encode($response);
