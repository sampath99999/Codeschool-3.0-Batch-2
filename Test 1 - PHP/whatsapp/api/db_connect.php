<?php
$host = "localhost";
$dbname = "media";
// $dsn = "pgsql:host=$host;dbname=$dbname";
$dbusername = "postgres";
$dbpassword = "postgres";

try {
    $pdo = new PDO($dsn, $dbusername, $dbpassword);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

   
    $userRole = "regularUser";  // Default to regular user

    
    if (isset($_SESSION['user_role']) && $_SESSION['user_role'] === 'admin') {
        $userRole = "admin";
    }

} catch (Exception $e) {
    echo "Connection failed ...." . $e->getMessage();
}
?>