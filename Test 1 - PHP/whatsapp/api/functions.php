<?php
function inserted_row($pdo)
{
    $query = "SELECT email FROM users ORDER BY user_id DESC LIMIT 1;";
    $query = $pdo->query($query);
    $row = $query->fetch(PDO::FETCH_ASSOC);
    return $row;
}

function insertAndGenerateToken($pdo, $email, $password)
{
    try {
        // Generate token
        $new_token = uniqid();

        // Set token
        $query = $pdo->prepare("UPDATE users SET token = :newtoken WHERE email = :email AND password = :password");
        $query->bindParam("email", $email);
        $query->bindParam("password", $password);
        $query->bindParam("newtoken", $new_token);
        $query->execute();

      
        $userRole = "regularUser";

        
        if (isset($_SESSION['user_role']) && $_SESSION['user_role'] === 'admin') {
            $userRole = "admin";
        }

        // Return token and user role
        return ['token' => $new_token, 'userRole' => $userRole];
    } catch (Exception $e) {
       
        return ['error' => 'Cannot generate token', 'exception' => $e->getMessage()];
    }
}
?>