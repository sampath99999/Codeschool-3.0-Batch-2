<?php
header('Content-Type: application/json');
require_once("cors.php");
require_once("functions.php");
require_once("connectiondb.php");

// Check for POST method
if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

// Validate required fields
if (!isset($_POST["email"]) || !isset($_POST["password"])) {
    response("Email and password are required!");
}

// Assign values
$email = $_POST["email"];
$password = $_POST["password"];

// Obtain PDO instance
$pdo = getPDO();

try {
    // Authenticate user
    $query = "SELECT  roleid, password FROM t_users WHERE email = :email";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":email", $email, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() == 0) {
        response("User not found");
    }
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    $hashed_password = $row["password"];
    $user_role = isset($row["roleid"]) ? $row["roleid"] : null;

    

    // Verify password
    if (password_verify($password, $hashed_password)) {
        // Password is correct, redirect based on user role
        if ($user_role == 1) {
            response("Login successful for user", true, ['redirect' => 'user.html']);
        } elseif ($user_role == 2) {
            response("Login successful for admin", true, ['redirect' => 'admin.html']);
        } else {
            response("Unknown user role");
        }
    } else {
        response("Incorrect password");
    }
} catch (Exception $e) {
    response("Something went wrong: " . $e->getMessage());
}
?>
