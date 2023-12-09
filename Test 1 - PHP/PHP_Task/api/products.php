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

// if (!isset($_POST["url"]) || !isset($_POST["title"]) || !isset($_POST["description"]) || !isset($_POST["price"]) || !isset($_POST["seller1"]) || !isset($_POST["mode"])) {
//     response("All fields are required!");
// }


$url = $_POST["url"];
$title = $_POST["title"];
$description = $_POST["description"];
$price = $_POST["price"];
$seller1 = $_POST["seller1"];
$mode = $_POST["mode"];


$pdo = getPDO();


$listingQuery = "INSERT INTO productslisting (url, title, description, price,user_id,status) VALUES (:url, :title, :description, :price,:seller1,:mode)";
$listingStmt = $pdo->prepare($listingQuery);
$listingStmt->bindParam(':url', $url, PDO::PARAM_STR);
$listingStmt->bindParam(':title', $title, PDO::PARAM_STR);
$listingStmt->bindParam(':description', $description, PDO::PARAM_STR);
$listingStmt->bindParam(':price', $price, PDO::PARAM_INT);
$listingStmt->bindParam(':seller1', $seller1, PDO::PARAM_INT);
$listingStmt->bindParam(':mode', $mode, PDO::PARAM_STR);


$listingStmt->execute();

if ($listingStmt->rowCount() > 0) {
 
    echo json_encode(["status" => true, "message" => "Data added successfully"]);
} else {
   
    echo json_encode(["status" => false, "message" => "Failed to add data"]);
}
?>
