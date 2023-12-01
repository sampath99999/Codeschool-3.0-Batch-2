<?php

require_once("./response.php");
require_once("./dbconnect.php");

$iname = $_POST['iname'];
$ilink = $_POST['ilink'];
$image = $_POST['image'];



try {

    $stmt = $pdo->prepare("insert into image (image,image_name,image_link) values (?,?,?)");
    $stmt->execute([$image, $iname, $ilink]);
    response(true, "Product Added Successfully!");

} catch (PDOException $e) {
    response(false, "{$e->getMessage()}");
}