<?php

require_once("../includes/functions.php");
require_once("../includes/dbconnect.php");

$product = $_POST['product'];
$userID = $_POST['user_id'];


if (!(array_key_exists('user_id', $_POST)) || !$_POST['user_id']) {
  response(false, "Invalid User ID");
}
if (!(array_key_exists('product', $_POST)) || !$_POST['product']) {
  response(false, "Invalid Products");
}

try {
  
  if (!$product) {

    echo json_encode(array('status' => false, 'msg' => 'No data found'));
    return;
  }
  $stmt1 = $pdo->prepare('select * from users where id=?;');
  $stmt1->execute([$userID]);
  $result1 = $stmt1->fetch(PDO::FETCH_ASSOC);
  if (count($result1) == 0) {
    response(false, "Not a Valid User");

  }
  $stmt2 = $pdo->prepare('select * from product where id=?;');
  $stmt2->execute([$product['id']]);
  $result2 = $stmt2->fetch(PDO::FETCH_ASSOC);
  if (count($result2) == 0) {
    response(false, "No Products Found");
  }

  $statement = $pdo->prepare('insert into cart (product_id,user_id) values(?,?)');
  $statement->execute([$product['id'], $userID]);
  response(true, "Success");

} catch (PDOException $e) {
  response(false, $e->getMessage());
}
