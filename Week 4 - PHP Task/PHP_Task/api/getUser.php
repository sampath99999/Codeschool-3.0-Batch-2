<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');
require_once("./../utils/db.php");
require_once("./../utils/functions.php");


if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["token"])) {
    response("Token is required!");
}

$token = $_POST["token"];

$pdo = getPDO();

$query = "SELECT id, user_name FROM usersdetails WHERE token = :token";
$stmt = $pdo->prepare($query);
$stmt->bindParam("token", $token, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount()  == 0) {
    response("Invalid User, Please Login Again!");
}

$user = $stmt->fetch(PDO::FETCH_ASSOC);
response("Success", true, $user);
