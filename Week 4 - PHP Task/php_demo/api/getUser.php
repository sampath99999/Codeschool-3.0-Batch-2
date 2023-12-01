<?php

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

$query = "SELECT id, name FROM users WHERE token = :token";
$stmt = $pdo->prepare($query);
$stmt->bindParam("token", $token, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount()  == 0) {
    response("Invalid User, Please Login Again!");
}

$user = $stmt->fetch(PDO::FETCH_ASSOC);
response("Success", true, $user);
