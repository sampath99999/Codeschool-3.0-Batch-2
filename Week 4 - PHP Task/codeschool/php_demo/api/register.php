<?php
include("./utils/cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["name"])) {
    response("Name is required!");
}
if (!isset($_POST["email"])) {
    response("Email is required!");
}
if (!isset($_POST["password"])) {
    response("Password is required!");
}


$name = $_POST["name"];
$email = $_POST["email"];
$password = md5($_POST["password"]);

// TODO validations

$pdo = getPDO();

// Email Already exists
$query = "SELECT * FROM users WHERE email = :email";
$stmt = $pdo->prepare($query);
$stmt->bindParam("email", $email, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount()  > 0) {
    response("Email already exists");
}

// Inserting
$query = "INSERT INTO users (name, email, password) VALUES (:name, :email, :password)";

$stmt = $pdo->prepare($query);
$stmt->bindParam("name", $name, PDO::PARAM_STR);
$stmt->bindParam("email", $email, PDO::PARAM_STR);
$stmt->bindParam("password", $password, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount() != 0) {
    response("Registered Successfully!", true);
}

response("Something went wrong!");
