<?php

require_once("../includes/functions.php");
require_once("../includes/dbconnect.php");

$status = true;

$product_name = $_POST["productName"];

try {
    $stmt = $pdo->prepare("DELETE FROM product WHERE name = ?;");
    $stmt->execute([$product_name]);
    response(true, "Product Deleted Successfully!");
} catch (PDOException $e) {
    response(false, "{$e->getMessage()}");
}
