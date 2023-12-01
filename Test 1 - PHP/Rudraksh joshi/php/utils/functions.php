<?php
require_once('db_connect.php');

function check_admin($token)
{
    $pdo = generatePDO();
    $query = $pdo->prepare("SELECT * FROM users where token = :token AND id = 1");
    $query->bindParam("token", $token);
    $query->execute();
    if ($query->rowCount() > 0) {
        return true;
    } else {
        return false;
    }
}
