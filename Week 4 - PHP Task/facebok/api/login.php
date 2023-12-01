<?php
require_once("response.php");
require_once("db_connect.php");
require_once("functions.php");
if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response(false, "Illegal access");
}
// response(true, "test");

$email = $_POST['email'];
$password = $_POST['password'];
// hashing
$password = md5($password);

$query = $pdo->prepare("SELECT full_name FROM users WHERE email = :email AND password = :password");
$query->bindParam("email", $email);
$query->bindParam("password", $password);

$query->execute();

// get full name value only
$full_name = $query->fetch(PDO::FETCH_ASSOC)['full_name'];

if ($query->rowCount() == 1) {

    // response(true, $email, $password);
    $token =  insertAndGenerateToken($pdo, $email, $password);
    // response(true, 'name test', $full_name);
    response(true, "token generated", ['token' => $token]);

    // response(true, "test", $row);

} else {
    response(false, "wrong password or email");
}
