<?php


require_once('../includes/prod_db_connect.php');
require_once('../includes/response.php');
function get_all_products()
{
    $pdo = generate_PDO();
    $query = $pdo->prepare("Select * from products order by product_id DESC");
    $query->execute();

    $product_rows = $query->fetchAll(PDO::FETCH_ASSOC);

    if ($query->rowCount() > 0) {

        return $product_rows;
    } else {
        return 'error';
    }
}

$result = get_all_products();
if ($result == 'error') {
    response(false, "query not successful");
} else {
    response(true, "query successful", $result);
}

