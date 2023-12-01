<?php
require_once('../includes/prod_db_connect.php');
require_once('../api/response.php');

$headers = apache_request_headers();

// response(true, 'test', 'test');


if (!isset($headers['token'])) {
    response(false, "token is required");
}
$retrieved_Token = $headers['token'];

try {
    $pdo = generate_PDO();
    $query = $pdo->prepare("SELECT full_name from users where token = :token");
    $query->bindParam("token", $retrieved_Token);
    $query->execute();
    if ($query->rowCount() > 0) {
        $result = $query->fetch(PDO::FETCH_ASSOC);
        response(true, "token validated", $result);
    } else {
        http_response_code(401);
    }
} catch (Exception $e) {
    response(false, "something went wrong");
}
