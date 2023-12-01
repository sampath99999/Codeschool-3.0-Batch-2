<?php

require_once("db_connect.php");

function set_token($token, $password)
{

    try {
        $pdo = generatePDO();
        $query = $pdo->prepare('UPDATE users SET token = :token WHERE password = :password');
        $query->bindParam('token', $token);
        $query->bindParam('password', $password);
        $query->execute();
        return true;
    } catch (Exception $e) {
        response("could not set token in db error", $e->getMessage());
    }
}

function get_userid($token)
{
    try {
        $pdo = generatePDO();
        $query = $pdo->prepare('SELECT id FROM users WHERE token = :token;');
        $query->bindParam('token', $token);
        $query->execute();
        if ($query->rowCount() != 0) {
            $result = $query->fetch(PDO::FETCH_ASSOC);
            return $result;
        }
        response("No user id found");
    } catch (Exception $e) {
        response("could not get user id  from db error", $e->getMessage());
    }
}
