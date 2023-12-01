<?php

require_once('../includes/prod_db_connect.php');
require_once('../includes/response.php');

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    exit("ILLEGAL ACESS");
}

$product_name = $_POST['product_name'];
$category_type = $_POST['category_type'];
$product_price = $_POST['product_price'];


if (empty($product_name) || empty($category_type) || empty($product_price)) {

    response(false, "cannot insert...");
}


$pdo = generate_PDO();

try {

    $query = $pdo->prepare("INSERT INTO products (product_name,category_type,price) VALUES (:product_name,:category_type,:product_price);");
    $query->bindParam("product_name", $product_name);
    $query->bindParam("category_type", $category_type);
    $query->bindParam("product_price", $product_price);
    $query->execute();
    $row = inserted_row($pdo);
    response(true, "inserted product", $row);
} catch (Exception $e) {
    response(false, "cannot insert.");
}

function inserted_row($pdo)
{
    $query = "Select * from products order by product_id desc limit 1;";
    $query = $pdo->query($query);
    $row = $query->fetch(PDO::FETCH_NUM);
    return $row;
}
