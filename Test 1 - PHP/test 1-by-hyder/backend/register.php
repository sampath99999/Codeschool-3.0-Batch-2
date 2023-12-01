<?php
header('Content-Type: application/json');
require_once("cors.php");
include("functions.php");
require_once("connectiondb.php");

// Check for POST method
if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

// Validate required fields
if (!isset($_POST["first_name"]) || !isset($_POST["last_name"]) || !isset($_POST["email"]) || !isset($_POST["phone"]) || !isset($_POST["password"])) {
    response("All fields are required!");
}

// Assign values
$first_name = $_POST["first_name"];
$last_name = $_POST["last_name"];
$email = $_POST["email"];
$phone = $_POST["phone"];
$password = $_POST["password"];

// Validate email format
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    response("Invalid email format");
}

// Obtain PDO instance
$pdo = getPDO();

try {
    // Check if email already exists
    $query = "SELECT * FROM t_users WHERE email = :email";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":email", $email, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        response("Email already exists");
    }

    // Hashing the password 
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

    // Inserting user data
    $query = "INSERT INTO t_users (first_name, last_name, email, phone, password) VALUES (:first_name, :last_name, :email, :phone, :password)";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":first_name", $first_name, PDO::PARAM_STR);
    $stmt->bindParam(":last_name", $last_name, PDO::PARAM_STR);
    $stmt->bindParam(":email", $email, PDO::PARAM_STR);
    $stmt->bindParam(":phone", $phone, PDO::PARAM_STR);
    $stmt->bindParam(":password", $hashedPassword, PDO::PARAM_STR); 
    $stmt->execute();

    response("User registered successfully", true);
} catch (Exception $e) {
    response("Something went wrong: " . $e->getMessage());
}
?>
