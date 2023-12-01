<?php

require_once("./dbconnect.php");
require_once("./response.php");

$email = $_POST['emailId'];
$name = $_POST['name'];
$password = $_POST['password'];

$status = true;

// Validation

if (!(array_key_exists('emailId', $_POST)) || !$_POST['emailId']) {
    response(false, "Please enter the correct e-Mail ID");
}

if (!(array_key_exists('password', $_POST)) || !$_POST['password']) {
    response(false, "Please enter the correct Password");
}

if (!$status) {
    response(false, "Please fill in the required fields");
}

if (strlen($name) > 20) {
    response(false, "Please fill in your name in less than 20 characters");

}

if (preg_match('/[\'{#~?><>,|=_^£$%&*()}+¬-]/', $email)) {
    response(false, "Please fill in your e-Mail ID with just 1 @");

}

if (strlen($password) < 8) {
    response(false, "Password: Minimum 8 Characters");

}

// Database Entry

try {
    $stmt1 = $pdo->prepare("select * from users where email=?");
    $stmt1->execute([$email]);
    $result = $stmt1->fetchAll(PDO::FETCH_ASSOC);

    if (count($result) != 0) {
        response(true, "Record Exists!", $result);
    }
    $stmt2 = $pdo->prepare("insert into users (user_type_id,name,email,password) values (?,?,?,?); ");
    $stmt2->execute([2, $name, $email, $password]);

    response(true, "Signed Up Successfully!", null);

} catch (PDOException $e) {
    response(false, "{$e->getMessage()}");
}