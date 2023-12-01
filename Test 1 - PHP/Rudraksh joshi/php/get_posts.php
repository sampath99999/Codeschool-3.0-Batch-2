<?php

require_once("./utils/db_connect.php");
require_once("./utils/response.php");
require_once("./utils/functions.php");

if ($_SERVER["REQUEST_METHOD"] != "GET") {
    response("ONLY GET METHOD ACCEPTED");
}




try {
    $pdo = generatePDO();
    // returns statement object
    $query = $pdo->prepare("SELECT * FROM posts");
    $query->execute();
    if ($query->rowCount() > 0) {
        $posts = $query->fetchAll(PDO::FETCH_ASSOC);
        response("got post data successfully", true, $posts);
    } else {
        response("did not get post data successfully");
    }
} catch (Exception $e) {

    response("Something went wrong while getting post form  database" . $e->getMessage());
}
