<?php

require_once("functions.php");

define("DB_HOST", "localhost");
define("DB_PORT", "5432");
define("DB_NAME", "php1");
define("DB_USER", "postgres");
define("DB_PWD", "hyder82a9");

function getPDO(){
    try {
        $conStr = "pgsql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";user=" . DB_USER . " password=" . DB_PWD;
        $pdo = new \PDO($conStr);
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        return $pdo;
    } catch(\PDOException $e){
    
        error_log("Connection failed: " . $e->getMessage());
        
        
        $errorMessage = (defined('ENVIRONMENT') && ENVIRONMENT === 'development') ? $e->getMessage() : "Server Error";
        
        http_response_code(500);
        response($errorMessage);
    }
}
?>

