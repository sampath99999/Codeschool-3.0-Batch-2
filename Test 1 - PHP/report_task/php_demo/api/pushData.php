<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if($_SERVER["REQUEST_METHOD"] != "POST"){
    response("Only POST method accepted!");
}
if(!isset($_POST["image"])){
    response("image is required!");
}

if(!isset($_POST["product_name"])){
    response("product_name is required!");
}
if(!isset($_POST["category"])){
    response("cateogory is required!");
}
if(!isset($_POST["sku"])){
    response("sku is required!");
}
if(!isset($_POST["variant"])){
    response("variant is required!");
}

if(!isset($_POST["price"])){
    response("price is required!");
}
if(!isset($_POST["status"])){
    response("status is required!");
}


$image_url=$_post["image"];
$product_name = $_POST["product_name"];
$category=$_POST["category"];
$sku=$_POST["sku"];
$variant=$_POST["variant"];
$price = $_POST["price"];
$status= $_POST["status"];


// TODO validations

$pdo = getPDO();

// Email Already exists
$query = "SELECT * FROM products WHERE product_name = :product_name";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":product_name", $product_name, PDO::PARAM_STR);
$stmt->execute();

if($stmt->rowCount()  > 0){
    response("name already exists");
}

// Inserting
$query = "INSERT INTO products ( product_name, category, sku,variant,price,status,image) VALUES (:product_name, :category, :sku,:variant,:price,:status,:image)";
$stmt = $pdo->prepare($query);
$stmt->bindParam("image", $image_url, PDO::PARAM_STR);
$stmt->bindParam("product_name", $product_name, PDO::PARAM_STR);
$stmt->bindParam("category", $category, PDO::PARAM_STR);
$stmt->bindParam("sku", $sku,PDO::PARAM_STR);
$stmt->bindParam("variant",$variant,PDO::PARAM_STR);
$stmt->bindParam("price", $price, PDO::PARAM_STR);
$stmt->bindParam("status",$status,PDO::PARAM_STR);
$stmt->execute();

if($stmt->rowCount() != 0){
    response("Products inserted Successfully!", true);
}

response("Something went wrong!");


