<?php

require_once("./includes/functions.php");
require_once("./includes/connectiondb.php");

$name = $_POST['name'];
$description = $_POST['description'];
$image = $_POST['image'];



try {

    $stmt = $pdo->prepare("insert into plots (name,description,image) values (?,?,?)");
    $stmt->execute([$name, $description, $image]);
    response(true, "Product Added Successfully!");

} catch (PDOException $e) {
    response(false, "{$e->getMessage()}");
}