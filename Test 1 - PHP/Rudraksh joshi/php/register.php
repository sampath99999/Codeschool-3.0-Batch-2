<?php

require_once("./utils/db_connect.php");
require_once("./utils/response.php");


if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("ONLY POST METHOD ACCEPTED");
}

$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];;
if (empty($email) || empty($password) || empty($username)) {

    response("one or more field is empty");
}

// todo hash password
$password = md5($password);
try {
    $pdo = generatePDO();
    // returns statement object
    $query = $pdo->prepare("INSERT INTO users (user_name,email,password)VALUES(:username,:email,:password)");
    $query->bindParam("email", $email);
    $query->bindParam("username", $username);
    $query->bindParam("password", $password);

    $query->execute();

    response("inserted values successfully", true);
} catch (Exception $e) {

    response("Something went wrong while inserting into database" . $e->getMessage());
}
