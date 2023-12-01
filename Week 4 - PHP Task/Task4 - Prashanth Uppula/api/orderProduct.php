<?php

require_once("../includes/functions.php");
require_once("../includes/connectiondb.php");

$product = $_POST['product'];
$userID = $_POST['user_id'];

if (count($product) == 0) {
  response(false, "Please select an item to place order!", null);
}

if (!(array_key_exists('user_id', $_POST)) || !$_POST['user_id']) {
  response(false, "Invalid User ID");
}
if (!(array_key_exists('product', $_POST)) || !$_POST['product']) {
  response(false, "Invalid Products");
}

try {

  if (!$product) {

    response(false, "No Data Found!");
  }
  $stmt1 = $pdo->prepare('select * from users where id=?;');
  $stmt1->execute([$userID]);
  $result1 = $stmt1->fetch(PDO::FETCH_ASSOC);
  if (count($result1) == 0) {
    response(false, "Invalid User");
  }
  $stmt2 = $pdo->prepare('select * from product where id=?;');
  $stmt2->execute([$product[0]['id']]);
  $result2 = $stmt2->fetch(PDO::FETCH_ASSOC);
  if (count($result2) == 0) {
    response(false, "Invalid Products");

  }

  $order_no = rand(1, 100);

  $insertQuery = "INSERT INTO orders (user_id, product_id, quantity, order_no) VALUES";

  for ($i = 0; $i < count($product); $i++) {
    $insertQuery .= "({$product[$i]['id']}, {$product[$i]['quantity']}, $order_no)";
    if ($i != (count($product) - 1)) {
      $insertQuery .= ", ";
    }
  }

  $pdo->beginTransaction();
  $stmt = $pdo->prepare($insertQuery);
  $stmt->execute();


  $stmt2 = $pdo->prepare('delete from cart where user_id = ?');
  $stmt2->execute([$userID]);

  $pdo->commit();
  response(true, "Order Placed Successfully!", null);

} catch (PDOException $e) {
  $pdo->rollBack();
}