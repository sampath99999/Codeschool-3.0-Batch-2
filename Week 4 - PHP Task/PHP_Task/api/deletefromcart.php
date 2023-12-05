<?php


header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

require_once("./../utils/db.php");


$pdo = getPDO();


$deleteQuery = "DELETE FROM listing WHERE mode = 'sold-out'";
$deleteStmt = $pdo->prepare($deleteQuery);


$deleteStatus = $deleteStmt->execute();


if ($deleteStatus) {
    echo json_encode(["status" => true]);
} else {
    echo json_encode(["status" => false, "message" => "Failed to delete entries."]);
}
?>
