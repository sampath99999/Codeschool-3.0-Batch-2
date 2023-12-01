<?php
require_once("response.php");
require_once('../includes/db_connect.php');
require_once("functions.php");
if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response(false, "Illegal access");
}

$email = $_POST['email'];
$password = $_POST['password'];
$password = md5($password);

$query = $pdo->prepare("SELECT full_name FROM users WHERE email = :email AND password = :password");
$query->bindParam("email", $email);
$query->bindParam("password", $password);

$query->execute();

$full_name = $query->fetch(PDO::FETCH_ASSOC)['full_name'];

if ($query->rowCount() == 1) {

    $token =  insertAndGenerateToken($pdo, $email, $password);
    response(true, "token generated", ['token' => $token]);


} else {
    response(false, "wrong password or email");
}
