<?php
function inserted_row($pdo)
{
    $query = "Select full_name,email from users order by user_id desc limit 1;";
    $query = $pdo->query($query);
    $row = $query->fetch(PDO::FETCH_ASSOC);
    return $row;
}


function insertAndGenerateToken($pdo, $email, $password)
{
    try {
        $new_token = uniqid();

        $query = $pdo->prepare("UPDATE users SET token = :newtoken WHERE email = :email AND password = :password");
        $query->bindParam("email", $email);
        $query->bindParam("password", $password);
        $query->bindParam("newtoken", $new_token);
        $query->execute();
        $result = $query->fetch(PDO::FETCH_ASSOC);
        return $new_token;
    } catch (Exception $e) {
        response("false", "Cannot Generate Token", $e);
    }
}
