<?php

require_once("../includes/functions.php");
require_once("../includes/connectiondb.php");
$status = true;

try {
    $stmt1 = $pdo->prepare("SELECT * FROM category ORDER BY id");
    $stmt1->execute();
    $result1 = $stmt1->fetchAll(PDO::FETCH_ASSOC);
    $message = "Received Data Successfully!";

    $stmt2 = $pdo->prepare("SELECT * FROM product");
    $stmt2->execute();
    $result2 = $stmt2->fetchAll(PDO::FETCH_ASSOC);

    if (count($result1) == 0) {
        $status = false;
        $message = "Category not Found!";
        response($status, $message, $result1);
    }

    if (count($result2) == 0) {
        $status = false;
        $message = "Products not Found!";
        response($status, $message, $result1);
    }

    response($status, $message, ["category" => $result1, "product" => $result2]);

} catch (PDOException $e) {
    response(false, $e->getMessage());
}