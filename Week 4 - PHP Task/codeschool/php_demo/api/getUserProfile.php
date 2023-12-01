<?php
require_once("./utils/functions.php");
require_once("./utils/db.php");


if ($_SERVER["REQUEST_METHOD"] != "GET") {
    response("Only GET method is accepted");
}

// Obtain PDO instance
$pdo = getPDO();

// Query
$query = "SELECT  name,email FROM users ";
$stmt = $pdo->prepare($query);
$stmt->execute();
$products = $stmt->fetchAll(PDO::FETCH_ASSOC);

header('Content-Type: application/json');
echo json_encode($products);
?>