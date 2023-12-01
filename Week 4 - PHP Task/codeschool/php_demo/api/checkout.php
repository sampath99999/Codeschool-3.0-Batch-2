<?php
include("./utils/cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["product"])) {
    response("Product is required!");
}
if (!isset($_POST["quantity"])) {
    response("Quantity is required!");
}

$product = $_POST["product"];
$quantity = $_POST["quantity"];
$total = $_POST["total"]; // Assuming the total is calculated on the client-side

$pdo = getPDO();

// Assuming you have a 'orders' table with columns 'product', 'quantity', 'total'
$query = "INSERT INTO orders (product, quantity, total) VALUES (:product, :quantity, :total)";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":product", $product, PDO::PARAM_STR);
$stmt->bindParam(":quantity", $quantity, PDO::PARAM_INT);
$stmt->bindParam(":total", $total, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount() == 0) {
    response("Failed to place order!");
}

response("Order placed successfully", true);
?>