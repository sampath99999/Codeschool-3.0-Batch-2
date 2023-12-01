<?php

require_once("../Database/functions.php");
require_once("../Database/dbconnection.php");


if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["username"])) {
    response("Username is needed");
}
if (!isset($_POST["password"])) {
    response("Password is needed");
}if (!isset($_POST["name"])) {
    response("Name is needed!");
}
if (!isset($_POST["email"])) {
    response("Email Date needed!");
}

if (!isset($_POST["number"])) {
    response("Number amount needed!");
}

$username=$_POST["username"];
$password=md5($_POST["password"]);
$name=$_POST["name"];
$email=$_POST["email"];
$number=$_POST["number"];

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    response("email is not in correct format");
  }
$pdo = getPDO();


$query= "INSERT INTO users (username,password,name,email,number) VALUES (:username, :password,:name,:email,:number)";
$stmt = $pdo->prepare($query);
$stmt->bindParam("username", $username);
$stmt->bindParam("password", $password);  
$stmt->bindParam("name", $name);
$stmt->bindParam("email", $email); 
$stmt->bindParam("number", $number); 

$stmt->execute();


if ($stmt->rowCount() != 0) {
    response("Registered Successfully!", true);
} else {response("something went wrong",false);}
?>