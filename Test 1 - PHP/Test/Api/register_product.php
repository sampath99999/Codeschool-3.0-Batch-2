<?php

require_once("../Database/functions.php");
require_once("../Database/dbconnection.php");


if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}
if (!isset($_POST["product_name"])) {
    response("Product Name needed!");
}
if (!isset($_POST["product_description"])) {
    response("Product Description is required!");
}
if (!isset($_POST["product_image"])) {
    response("Product Image is required!");
}
if (!isset($_POST["product_price"])) {
    response("Product price is required!");
}if (!isset($_POST["product_rating"])) {
    response("Product rating is required!");
}if (!isset($_POST["token"])) {
    response("Token is required!");
}

$token=$_POST["token"];




$pdo = getPDO();



$query = "SELECT * FROM users where token = :token ";
$stmt = $pdo->prepare($query);
$stmt->bindParam("token", $token);

$stmt->execute();


$user = $stmt->fetch(PDO::FETCH_ASSOC);

$key= $user["username"];


$product_name = $_POST["product_name"];
$product_description = $_POST["product_description"];
$product_image = $_POST["product_image"];
$product_price = $_POST["product_price"];
$product_rating= $_POST["product_rating"];
$user_id = $key;



$query= "INSERT INTO products (product_name,product_description,product_image,product_price,product_rating,users_id)
 VALUES (:product_name, :product_description, :product_image, :product_price,:product_rating,:user_id)";
$stmt = $pdo->prepare($query);
$stmt->bindParam("product_name", $product_name);
$stmt->bindParam("product_description", $product_description);  
$stmt->bindParam("product_image", $product_image);
$stmt->bindParam("product_price", $product_price);  
$stmt->bindParam("product_rating", $product_rating);
$stmt->bindParam("user_id", $user_id);  

$stmt->execute();

if ($stmt->rowCount() != 0) {
    response("Registered Successfully!", true);
} else {response("something went wrong",false);}
?>