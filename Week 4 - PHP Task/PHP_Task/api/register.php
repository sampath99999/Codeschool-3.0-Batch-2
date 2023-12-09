<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');
require_once("./../utils/db.php");
require_once("./../utils/functions.php");
include("./../utils/vaish.php");

if ($_SERVER["REQUEST_METHOD"] != "POST"){
    response("only POST method accepted");
}

if(!isset($_POST["name"])){
    response("Name is required!");
}
if(!isset($_POST["email"])) {
    response("Email is required!");
}
if(!isset($_POST["password"])) {
    response("password is required!");
}


$name= $_POST["name"];
$number=$_POST["number"];
$email= $_POST["email"];
$password= md5($_POST["password"]);

$pdo = getPDO();

$query = "SELECT * FROM  usersdetails WHERE email=:email";
$stmt= $pdo->prepare($query);
$stmt->bindParam(":email",$email,PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount()>0){
    response("Email already exists");
}

$query = "INSERT INTO usersdetails (user_name,phone_number,email,password) VALUES (:name,:number, :email, :password)";
$stmt =$pdo->prepare($query);
$stmt->bindParam(":name",$name,PDO::PARAM_STR);
$stmt->bindParam(":number",$number,PDO::PARAM_STR);
$stmt->bindParam(":email",$email,PDO::PARAM_STR);
$stmt->bindParam(":password",$password,PDO::PARAM_STR);

$stmt->execute();

if ($stmt->rowCount()!=0){
    response("Registered Successfully!",true);
}

response("Something went wrong!");
