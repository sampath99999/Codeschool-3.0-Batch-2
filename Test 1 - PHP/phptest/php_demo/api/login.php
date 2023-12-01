<?php
// include("./utils/cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["userName"])) {
    response("UserName is required!");
}
if (!isset($_POST["password"])) {
    response("Password is required!");
}

$userName = $_POST["userName"];
$password = md5($_POST["password"]);



$pdo = getPDO();

$query = "SELECT user_id, username FROM users WHERE username = :userName AND password = :password";
$stmt = $pdo->prepare($query);
$stmt->bindParam("userName", $userName, PDO::PARAM_STR);
$stmt->bindParam("password", $password, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount()  == 0) {
    response("UserName or Password is incorrect!");
}

$token = uniqid();

$query = "UPDATE users SET token = :token WHERE username = :userName AND password = :password";
$stmt = $pdo->prepare($query);
$stmt->bindParam("token", $token);
$stmt->bindParam("userName", $userName);
$stmt->bindParam("password", $password);
$stmt->execute();


$user = $stmt->fetch(PDO::FETCH_ASSOC);
response("Successfully Logged In", true, ["token" => $token]);
