<?php

require_once("./utils/db_connect.php");
require_once("./utils/response.php");
require_once("./utils/functions.php");

$headers = apache_request_headers();
$token = $headers['token'];



try {
    $pdo = generatePDO();
    // returns statement object
    $query = $pdo->prepare("SELECT * FROM users where token = :token and id = 1");
    $query->bindParam("token", $token);
    $query->execute();
    if ($query->rowCount() > 0) {

        response("admin", true);
    } else {
        response("user", true);
    }
} catch (Exception $e) {

    response("Something went wrong while getting post form  database" . $e->getMessage());
}
