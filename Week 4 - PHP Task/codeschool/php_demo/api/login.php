<?php
include("./utils/cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["email"])) {
    response("Email is required!");
}
if (!isset($_POST["password"])) {
    response("Password is required!");
}

$email = $_POST["email"];
$password = md5($_POST["password"]);



$pdo = getPDO();

$query = "SELECT id, name FROM users WHERE email = :email AND password = :password";
$stmt = $pdo->prepare($query);
$stmt->bindParam("email", $email, PDO::PARAM_STR);
$stmt->bindParam("password", $password, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount()  == 0) {
    response("Email or Password is incorrect!");
}

$token = uniqid();

$query = "UPDATE users SET token = :token WHERE email = :email AND password = :password";
$stmt = $pdo->prepare($query);
$stmt->bindParam("token", $token, PDO::PARAM_STR);
$stmt->bindParam("email", $email, PDO::PARAM_STR);
$stmt->bindParam("password", $password, PDO::PARAM_STR);
$stmt->execute();


$user = $stmt->fetch(PDO::FETCH_ASSOC);
response("Successfully Logged In", true, ["token" => $token]);
