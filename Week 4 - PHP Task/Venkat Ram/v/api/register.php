<?php
require_once('../includes/db_connect.php');
require_once("response.php");
require_once("functions.php");
if ($_SERVER["REQUEST_METHOD"] == "POST") {


    $fullname = isset($_POST["fullname"]) ? $_POST["fullname"] : "";
    $phone = isset($_POST["phone"]) ? $_POST["phone"] : "";
    $email = isset($_POST["email"]) ? $_POST["email"] : "";
    $username = isset($_POST["username"]) ? $_POST["username"] : "";
    $password = isset($_POST["password"]) ? $_POST["password"] : "";


    $password = md5($password);

    try {
        $query = $pdo->prepare("INSERT INTO users (full_name,phone_number,email,user_name,password) VALUES(:full_name,:phone_number,:email,:user_name,:password); ");
        $query->bindParam("full_name", $fullname);
        $query->bindParam("phone_number", $phone);
        $query->bindParam("email",  $email);
        $query->bindParam("user_name", $username);
        $query->bindParam("password", $password);
        $query->execute();
        
        $result = inserted_row($pdo);

        response(true, 'inserted successfully', $result);
    } catch (Exception $e) {
        response(false, "cannot insert details....try again", $e);
    }
} else {
    response(false, 'something went wrong');
}
