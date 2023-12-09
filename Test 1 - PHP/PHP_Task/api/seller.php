<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');
require_once("./../utils/db.php");
require_once("./../utils/functions.php");
include("./../utils/vaish.php");


try {
    $pdo = getPDO();
    $stmt = $pdo->prepare("SELECT user_name, phone_number FROM person WHERE role_id = 1");
    $stmt->execute();
    
    
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    
    echo json_encode($result);
} catch (PDOException $e) {
  
    echo json_encode(["error" => $e->getMessage()]);
}
?>
