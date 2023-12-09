<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

require_once("./../utils/db.php");
require_once("./../utils/functions.php");

if ($_SERVER["REQUEST_METHOD"] != "GET") {
    response("Only GET method accepted!");
}

if (!isset($_GET["userId"])) {
    response("User ID is required!");
}

$userId = $_GET["userId"];

try {
    $pdo = getPDO();

    $stmt = $pdo->prepare("SELECT user_name, phone_number FROM person WHERE id = :userId");
    $stmt->bindParam(":userId", $userId, PDO::PARAM_INT);
    $stmt->execute();

    $userDetails = $stmt->fetch(PDO::FETCH_ASSOC);

    header("Content-Type: application/json");
    echo json_encode($userDetails);
} catch (PDOException $e) {
    response("Database Error: " . $e->getMessage());
}


function response($message = "", $status = false, $data = null)
{
    echo json_encode(["status" => $status, "message" => $message, "data" => $data]);
    exit();
}
?>
