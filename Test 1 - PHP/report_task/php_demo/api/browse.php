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

// Verify user token
$query = "SELECT id FROM users WHERE token = :token";
$stmt = $pdo->prepare($query);
$stmt->bindParam("token", $token, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount() == 0) {
    response("Invalid token!");
}

// Now, perform a search for books (adjust the query based on your needs)
if (isset($_POST["search"])) {
    $searchValue = $_POST["search"];

    $searchQuery = "SELECT * FROM products WHERE product_name LIKE :search ";
    $searchStmt = $pdo->prepare($searchQuery);
    $searchStmt->bindValue(':search', '%' . $searchValue . '%', PDO::PARAM_STR);
    $searchStmt->execute();
    $results = $searchStmt->fetchAll(PDO::FETCH_ASSOC);

    if ($results) {
        response("Search successful", true, ["results" => $results]);
    } else {
        response("No results found.");
    }
} else {
    response("Search value is required!");
}
?>
