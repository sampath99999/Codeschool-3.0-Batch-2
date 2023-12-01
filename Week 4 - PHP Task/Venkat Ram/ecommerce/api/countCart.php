<?php

require_once("../includes/functions.php");
require_once("../includes/dbconnect.php");

$userID = $_POST['user_id'];

try {

  $statement = $pdo->prepare(" select count (product_id) from cart where user_id=?;");
  $statement->execute([$userID]);
  $result = $statement->fetchAll(PDO::FETCH_ASSOC);
  response(true, "Cart Count Received Successfully!", $result);

} catch (PDOException $e) {
  response(false, $e->getMessage());
}
