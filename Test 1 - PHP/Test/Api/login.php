<?php

require_once("../Database/functions.php");
require_once("../Database/dbconnection.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["username"])) {
    response(false,"Field is required!");
}
if (!isset($_POST["password"])) {
    response(false,"Password is required!");
}

$username = $_POST["username"];
$password = md5($_POST["password"]);


$pdo = getPDO();

$query = "SELECT * FROM users WHERE (username = :username OR number= :username OR email=:username) AND password = :password";
$stmt = $pdo->prepare($query);
$stmt->bindParam("username", $username);
$stmt->bindParam("password", $password);
$stmt->execute();

if ($stmt->rowCount()  == 0) {
    response("Email or Password is incorrect!");
}

$token = uniqid();

$query = "UPDATE users SET token = :token WHERE (username = :username OR number= :username OR email=:username) AND password = :password";
$stmt = $pdo->prepare($query);
$stmt->bindParam("token", $token);
$stmt->bindParam("username", $username);
$stmt->bindParam("password", $password);
$stmt->execute();


$user = $stmt->fetch(PDO::FETCH_ASSOC);
response("Successfully Logged In", true, ["token" => $token]);