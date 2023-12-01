<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

$pdo = getPDO();

$query = "SELECT * FROM shopping_cart";
$stmt = $pdo->prepare($query);
$stmt->execute();

$shopping_cart = $stmt->fetchAll(PDO::FETCH_ASSOC);

response("Items data fetched successfully", true, $shopping_cart);
