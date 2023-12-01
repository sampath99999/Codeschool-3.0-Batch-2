<?php

require_once("../includes/connectiondb.php");
require_once("../includes/functions.php");

$email = $_POST['emailId'];
$password = $_POST['password'];

$status = true;

if (!(array_key_exists('emailId', $_POST)) || !$_POST['emailId']) {
    response(false, "Please Enter a Valid e-Mail");
}

if (!(array_key_exists('password', $_POST)) || !$_POST['password']) {
    response(false, "Please Enter a Valid Password");
}

if (!$status) {
    response(false, "Please fill in the Required Fields");
}

if (strlen($email) > 64) {
    response(false, "Please Enter a Valid e-Mail");
} else if (preg_match('/[\'{#~?><>,|=_^£$%&*()}+¬-]/', $email)) {
    response(false, "Please Enter a Valid e-Mail, containing just one @");
}

if (strlen($password) < 8 || strlen($password) > 12) {
    response(false, "Password: Minimum 8 Characters; Maximum 12 Characters");
}

try {
    $statement = $pdo->prepare("SELECT id, name, email FROM users WHERE email = ? AND password = ?");
    $statement->execute([$email, $password]);
    $result = $statement->fetchAll(PDO::FETCH_ASSOC);

    if (count($result) == 0) {
        response(false, "Invalid Login Credentials Used, Please Try Again!");
    }

    response(true, "Signed In Successfully!", $result);

} catch (PDOException $e) {
    response(false, "{$e->getMessage()}");
}
