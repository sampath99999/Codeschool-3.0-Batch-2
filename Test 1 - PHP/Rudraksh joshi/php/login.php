<?php

require_once("./utils/db_connect.php");
require_once("./utils/response.php");
require_once("./utils/functions.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("ONLY POST METHOD ACCEPTED");
}


$email = $_POST['email'];
$password = $_POST['password'];;
if (empty($email) || empty($password)) {

    response("one or more field is empty");
}

$password = md5($password);
try {
    $pdo = generatePDO();
    // returns statement object
    $query = $pdo->prepare("SELECT * FROM users WHERE email = :email AND password = :password");
    $query->bindParam("email", $email);
    $query->bindParam("password", $password);

    $query->execute();

    if ($query->rowCount() > 0) {
        $token = uniqid();

        $pdo = generatePDO();
        $query = $pdo->prepare("UPDATE  users SET token = :token WHERE email = :email AND password = :password");
        $query->bindParam("token", $token);
        $query->bindParam("email", $email);
        $query->bindParam("password", $password);;
        $query->execute();
        $is_admin = check_admin($token);
        if ($is_admin) {
            response("admin", true, $token);
        } else {
            response("user", true, $token);
        }
    } else {

        response("cannot find user ");
    }
} catch (Exception $e) {

    response("Something went wrong while fetching from database" . $e->getMessage());
}
