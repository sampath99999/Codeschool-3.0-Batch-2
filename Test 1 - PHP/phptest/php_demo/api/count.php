<?php
include("./utils/cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");



$pdo = getPDO();
$queryActive = "SELECT COUNT(*) AS active_count FROM donations";
$stmtActive = $pdo->query($queryActive);
$resultActive = $stmtActive->fetch(PDO::FETCH_ASSOC);
$activeCount = $resultActive['active_count'];
$response = [
    'activeCount' => $activeCount,
];

echo json_encode($response);
