<?php
include("./utils/cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["token"])) {
    response("Token is required!");
}

$token = $_POST["token"];

$pdo = getPDO();

// Validate the user based on the token
$query = "SELECT id, name FROM users WHERE token = :token";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":token", $token, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount() == 0) {
    response("Invalid token. Please log in!");
}

$user = $stmt->fetch(PDO::FETCH_ASSOC);

// Fetch items from the cart for the logged-in user
$userId = $user["id"];
$cartQuery = "SELECT  quantity, total FROM cart WHERE user_id = :userId";
$cartStmt = $pdo->prepare($cartQuery);
$cartStmt->bindParam(":userId", $userId, PDO::PARAM_INT);
$cartStmt->execute();

$cartItems = $cartStmt->fetchAll(PDO::FETCH_ASSOC);

// Assuming the response function formats the output in a meaningful way
response("Cart items retrieved successfully", true, ["cartItems" => $cartItems]);
