<?php
session_start();

require_once("cors.php");
require_once("functions.php");
require_once("connectiondb.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["username"])) {
    response("username is required!");
}
if (!isset($_POST["password"])) {
    response("Password is required!");
}

$username = $_POST["username"];
$password = $_POST["password"];



$pdo = getPDO();

$query = "SELECT * FROM users WHERE (username = :username OR ddo_code= :username) AND password = :password";
$stmt = $pdo->prepare($query);
$stmt->bindParam("username", $username, PDO::PARAM_STR);
$stmt->bindParam("password", $password, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount()  == 0) {
    response("username or Password is incorrect!");
}



$token = uniqid();

$query = "UPDATE users SET token = :token WHERE (username = :username OR ddo_code = :username) AND password = :password";
$stmt = $pdo->prepare($query);
$stmt->bindParam("token", $token, PDO::PARAM_STR);
$stmt->bindParam("username", $username, PDO::PARAM_STR);
$stmt->bindParam("password", $password, PDO::PARAM_STR);
$stmt->execute();
$_SESSION["username"] = $username;


$user = $stmt->fetch(PDO::FETCH_ASSOC);
response("Successfully Logged In", true, ["token" => $token]);