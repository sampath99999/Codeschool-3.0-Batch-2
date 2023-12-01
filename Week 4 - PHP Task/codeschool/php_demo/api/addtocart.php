<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["user_id"]) || !isset($_POST["quantity"]) || !isset($_POST["total"])) {
    response("Quantity and total are required!");
}
$user_id = $_POST["user_id"];
$quantity = $_POST["quantity"];
$total = $_POST["total"];

$pdo = getPDO();

$query = "INSERT INTO shopping_cart (user_id ,quantity, total) VALUES (:user_id , :quantity, :total)";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":user_id", $user_id, PDO::PARAM_STR);
$stmt->bindParam(":quantity", $quantity, PDO::PARAM_STR);
$stmt->bindParam(":total", $total, PDO::PARAM_STR);

if ($stmt->execute()) {
    response("Items added successfully", true);
} else {
    response("Failed to add items", false);
}
