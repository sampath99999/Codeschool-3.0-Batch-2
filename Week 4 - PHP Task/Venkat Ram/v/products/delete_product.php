<?php
require_once('../includes/prod_db_connect.php');
require_once('../includes/response.php');
$product_name = $_POST['product_name'];
$category_type = $_POST['category_type'];

try {
    $pdo = generate_PDO();
    $query = $pdo->prepare("DELETE FROM products where product_name = :product AND category_type = :category");

    $query->bindParam('product', $product_name);
    $query->bindParam('category', $category_type);

    $query->execute();
    if ($query->rowCount() > 0) {
        $result = $query->fetch(PDO::FETCH_ASSOC);
        response(true, "Deleted Product", 1);
    }
    response(false, "cannot delete product..");
} catch (Exception $e) {
    response(false, "something went wrong");
}
$pdo = null;
