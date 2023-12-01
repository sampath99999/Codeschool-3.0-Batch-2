<?php

require_once("../includes/functions.php");
require_once("../includes/dbconnect.php");
$status = true;


try {

    $statement = $pdo->prepare("select user_id,order_no,name,image,price,discount,sum((price-discount)*quantity) as total_price,quantity from product as p join orders as o on p.id=o.product_id group by user_id, order_no, name, image, price, discount, quantity order by order_no ;");
    $statement->execute([]);
    $result = $statement->fetchAll(PDO::FETCH_ASSOC);

    if (count($result) == 0) {
        response(false, "No items ordered yet!", null);
    }

    response(true, "Order Loaded Successfully", $result);

} catch (PDOException $e) {
    $response = ["status" => false, "message" => $e->getMessage()];
    echo json_encode($response);
    return;
}
