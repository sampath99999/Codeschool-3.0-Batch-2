<?php

require_once("./utils/db_connect.php");
require_once("./utils/response.php");


if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("ONLY POST METHOD ACCEPTED");
}

$post_title = $_POST['postTitle'];
$post_image = $_POST['postImage'];
$post_content = $_POST['postContent'];
if (empty($post_title) || empty($post_image) || empty($post_content)) {

    response("one or more field  of post is empty");
}


try {
    $pdo = generatePDO();
    // returns statement object
    $query = $pdo->prepare("INSERT INTO posts (post_title,post_content,post_image)VALUES(:title,:content,:image)");
    $query->bindParam("title", $post_title);
    $query->bindParam("image", $post_image);
    $query->bindParam("content", $post_content);
    $query->execute();
    if ($query->rowCount() > 0) {
        response("inserted post data successfully", true);
    } else {
        response("did not insert post data successfully");
    }
} catch (Exception $e) {

    response("Something went wrong while inserting into database" . $e->getMessage());
}
