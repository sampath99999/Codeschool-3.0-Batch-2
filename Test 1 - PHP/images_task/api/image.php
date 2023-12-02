<?php

require_once("./response.php");
require_once("./dbconnect.php");

$status = true;

try {
    
    $stmt1 = $pdo->prepare("SELECT * FROM image ORDER BY id");
    $stmt1->execute();
    $result1 = $stmt1->fetchAll(PDO::FETCH_ASSOC);
    $message = "Received Images Successfully!";

    if (count($result1) == 0) {
        $status = false;
        $message = "Images not Found!";
        response($status, $message, $result1);
    }

    response($status, $message, $result1);

} catch (PDOException $e) {
    response(false, $e->getMessage());
}
