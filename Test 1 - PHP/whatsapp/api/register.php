<?php
require_once("../api/db_connect.php");
require_once("response.php");
require_once("functions.php");

// Check if the form data is submitted using POST only
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve and sanitize form data

    $email = filter_input(INPUT_POST, "email", FILTER_VALIDATE_EMAIL);
    $username = filter_input(INPUT_POST, "username", FILTER_SANITIZE_STRING);
    $password = filter_input(INPUT_POST, "password");

    // Validate input
    if ( !$email || !$username || !$password) {
        response(false, "Invalid input. Please provide all required fields.");
    }

    // Hash the password securely
    $hashedPassword = md5($password);

    try {
        // Prepare and execute the query
        $query = $pdo->prepare("INSERT INTO media_user ( email, user_name, password) VALUES( :email, :user_name, :password)");
       
        $query->bindParam(":email", $email);
        $query->bindParam(":user_name", $username);
        $query->bindParam(":password", $hashedPassword);
        $query->execute();


        response(true, "Inserted successfully");
    } catch (Exception $e) {
        response(false, "Cannot insert details. Try again.", $e);
    }
} else {
    response(false, 'Something went wrong');
}
?>