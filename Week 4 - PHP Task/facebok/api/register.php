<?php
require_once("../api/db_connect.php");
require_once("response.php");
require_once("functions.php");
// Check if the form data is submitted using post only

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Retrieve form data
    // var_dump($_POST);


    // if value is set, assign the value or assign empty string

    $full_name = isset($_POST["fullname"]) ? $_POST["fullname"] : "";
    $phone_number = isset($_POST["phone"]) ? $_POST["phone"] : "";
    $email = isset($_POST["email"]) ? $_POST["email"] : "";
    $user_name = isset($_POST["username"]) ? $_POST["username"] : "";
    $password = isset($_POST["password"]) ? $_POST["password"] : "";


        // hashing
    $password = md5($password);

    try {
        $query = $pdo->prepare("INSERT INTO users (full_name,phone_number,email,user_name,password) VALUES(:full_name,:phone_number,:email,:user_name,:password); ");
        $query->bindParam("full_name", $full_name);
        $query->bindParam("phone_number", $phone_number);
        $query->bindParam("email",  $email);
        $query->bindParam("user_name", $user_name);
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
