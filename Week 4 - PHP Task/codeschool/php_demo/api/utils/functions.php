<?php

function response($message = "", $status = false, $data = null)
{
    echo json_encode(["status" => $status, "message" => $message, "data" => $data]);
    exit();
}

function validateToken($pdo, $token)
{
    $query = "SELECT id, name FROM users WHERE token = :token";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam("token", $token, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount()  == 0) {
        response("Invalid User, Please Login Again!");
    }
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

