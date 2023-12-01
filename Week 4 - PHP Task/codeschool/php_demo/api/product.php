<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

include("./utils/cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["image"])) {
    response("Image is required!");
}
if (!isset($_POST["title"])) {
    response("Title is required!");
}
if (!isset($_POST["author"])) {
    response("Author is required!");
}
if (!isset($_POST["price"])) {
    response("Price is required!");
}

$image = $_POST["image"];
$title = $_POST["title"];
$author = $_POST["author"];
$price = ($_POST["price"]);

// TODO validations

$pdo = getPDO();

// Email Already exists

$query = "SELECT * FROM books WHERE     title = :title";
$stmt = $pdo->prepare($query);
$stmt->bindParam("title", $title, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount()  > 0) {
    response("E already exists");
}

// Inserting
$query = "INSERT INTO books (image ,title, author, price) VALUES ( :image ,:title, :author, :price)";

$stmt = $pdo->prepare($query);
$stmt->bindParam(":image", $image, PDO::PARAM_STR);
$stmt->bindParam(":title", $title, PDO::PARAM_STR);
$stmt->bindParam(":author", $author, PDO::PARAM_STR);
$stmt->bindParam(":price", $price, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount() != 0) {
    response("Added Successfully!", true);
}

response("Something went wrong!");

$query = "SELECT * FROM books";
// $result = pg_query($conn , $query);
