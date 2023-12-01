<?php
include("./utils/cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");

// Obtain PDO instance
$pdo = getPDO();

// Fetch data from the database
$query = "SELECT * FROM donations";
$stmt = $pdo->prepare($query);
$stmt->execute();
$Donations = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Return data as JSON
header('Content-Type: application/json');
echo json_encode($Donations);
