<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

require_once("./../utils/db.php");
require_once("./../utils/functions.php");
include("./../utils/vaish.php");


if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["url"]) || !isset($_POST["title"]) || !isset($_POST["description"]) || !isset($_POST["price"]) || !isset($_POST["mode"]) || !isset($_POST["sellername"]) || !isset($_POST["phone"])) {
    response("All fields are required!");
}


$url = $_POST["url"];
$title = $_POST["title"];
$description = $_POST["description"];
$price = $_POST["price"];
$mode = $_POST["mode"];
$sellername = $_POST["sellername"];
$phone = $_POST["phone"];


$pdo = getPDO();


$listingQuery = "INSERT INTO listing (url, title, description, price, mode,sellername,phone) VALUES (:url, :title, :description, :price, :mode,:sellername,:phone)";
$listingStmt = $pdo->prepare($listingQuery);
$listingStmt->bindParam(':url', $url, PDO::PARAM_STR);
$listingStmt->bindParam(':title', $title, PDO::PARAM_STR);
$listingStmt->bindParam(':description', $description, PDO::PARAM_STR);
$listingStmt->bindParam(':price', $price, PDO::PARAM_INT);
$listingStmt->bindParam(':mode', $mode, PDO::PARAM_STR);
$listingStmt->bindParam(':sellername', $sellername, PDO::PARAM_INT);
$listingStmt->bindParam(':phone', $phone, PDO::PARAM_STR);
$listingStmt->execute();

if ($listingStmt->rowCount() > 0) {
 
    echo json_encode(["status" => true, "message" => "Data added successfully"]);
} else {
   
    echo json_encode(["status" => false, "message" => "Failed to add data"]);
}
?>
