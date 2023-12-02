<?php
require_once("response.php");
require_once("db_connect.php");
require_once("functions.php");

// Check if the request method is POST
if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response(false, "Illegal access");
}

// Sanitize and validate input
$email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);
$password = filter_input(INPUT_POST, 'password');

// Check if email and password are provided
if (!$email || !$password) {
    response(false, "Invalid email or password");
}

// Hash the password securely
$hashedPassword =md5($password);

// Prepare and execute the query
$query = $pdo->prepare("SELECT user_name, password FROM media_user WHERE email = :email and password = :password");
$query->bindParam(":email", $email);
$query->bindParam(":password", $password);
$query->execute();

// Fetch user data
$userData = $query->fetch(PDO::FETCH_ASSOC);

if ($query->rowCount() > 0) {
    // Generate and insert a new token
    $token = insertAndGenerateToken($pdo, $userData['user_id'], $hashedPassword);

    // Provide necessary user information in the response
    response(true, "Login successful", [
        'user_name' => $userData['user_name'],
        // 'full_name' => $userData['full_name'],
        'token' => $token
    ]);
} else {
    response(false, "Wrong email or password");
}
?>