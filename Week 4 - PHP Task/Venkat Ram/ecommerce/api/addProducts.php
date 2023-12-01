<?php

require_once("../includes/functions.php");
require_once("../includes/dbconnect.php");

$status = true;

$category_id = $_POST["category_id"];
$name = $_POST["name"];
$price = $_POST["price"];
$discount = $_POST["discount"];
$image = $_POST["image"];
$token = $_POST["token"];



try {
    $stmt = $pdo->prepare("insert into product (category_id,name,price,discount,image) values (?,?,?,?,?)");
    $stmt->execute([$category_id, $name, $price, $discount, $image]);
    echo $token;
    response(true, "Product Added Successfully!");
} catch (PDOException $e) {
    response(false, "{$e->getMessage()}");
}
