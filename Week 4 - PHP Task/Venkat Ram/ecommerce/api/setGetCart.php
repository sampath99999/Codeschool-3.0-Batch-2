<?php

require_once("../includes/functions.php");
require_once("../includes/dbconnect.php");

$userId = $_POST['user_id'];
$products = $_POST['products'];

if (!(array_key_exists('user_id', $_POST)) || !$_POST['user_id']) {
    response(false, "Please Enter a Valid User ID");
}

try {

    if (!$products || count($products) == 0) {

        $result = $pdo->prepare(' select p.name,p.id,p.image,count(c.id) as quantity from product as p join cart as c on c.product_id = p.id where user_id=? group by p.id,p.name,p.price');
        $result->execute([$userId]);
        $product = $result->fetchAll(PDO::FETCH_ASSOC);
        response(true, "Success", $product);
    }

    for ($i = 0; $i < count($products); $i++) {
        $productId = $products[$i]["id"];
        $statement = $pdo->prepare("insert into cart (user_id,product_id) values(?,?)");
        $statement->execute([$userId, $productId]);
    }

    $result = $pdo->prepare('select p.name,p.id,p.image,count(c.id) as quantity from product as p join cart as c on c.product_id = p.id where user_id=? group by p.id,p.name
,p.price');
    $result->execute([$userId]);
    $product = $result->fetchAll(PDO::FETCH_ASSOC);

    response(true, "Success", $product);

} catch (PDOException $e) {
    response(false, $e->getMessage());
}
