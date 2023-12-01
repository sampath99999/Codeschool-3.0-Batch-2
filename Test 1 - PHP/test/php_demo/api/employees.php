<?php
include("cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");
if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["firstname"])) {
    response("firstName is required!");
}
if (!isset($_POST["lastname"])) {
    response("lastname is required!");
}
if (!isset($_POST["job"])) {
    response("position is required!");
}
if (!isset($_POST["email"])) {
    response("email is required!");
}
if (!isset($_POST["phone"])) {
    response("number is required!");
}
if (!isset($_POST["mobilefax"])) {
    response("mobilefax is required!");
}
if (!isset($_POST["fax"])) {
    response("fax is required!");
}

$firstname = $_POST["firstname"];
$lastname = $_POST["lastname"];
$job = $_POST["job"];
$email = $_POST["email"];
$phone = $_POST["phone"];
$mobilefax = $_POST["mobilefax"];
$fax = $_POST["fax"];
// TODO validations

$pdo = getPDO();
$query = "SELECT * FROM employee WHERE email = :email";
$stmt = $pdo->prepare($query);
$stmt->bindParam("email", $email, PDO::PARAM_STR);
$stmt->execute();

if ($stmt->rowCount()  > 0) {
    response("Name already exists");
}

// Inserting

$query = "INSERT INTO employee (firstname, lastname, job, email, phone, mobilefax, fax) VALUES (:firstname, :lastname, :job, :email, :phone, :mobilefax, :fax)";

$stmt = $pdo->prepare($query);
$stmt->bindParam(":firstname", $firstname, PDO::PARAM_STR);
$stmt->bindParam(":lastname", $lastname, PDO::PARAM_STR);
$stmt->bindParam(":job", $job, PDO::PARAM_STR);
$stmt->bindParam(":email", $email, PDO::PARAM_STR);
$stmt->bindParam(":phone", $phone, PDO::PARAM_INT);  // Use PDO::PARAM_INT for an integer
$stmt->bindParam(":mobilefax", $mobilefax, PDO::PARAM_STR);
$stmt->bindParam(":fax", $fax, PDO::PARAM_STR);
$stmt->execute();


if ($stmt->rowCount() != 0) {
    response("Registered Successfully!", true, [$firstname, $lastname, $job, $email, $phone, $mobilefax, $fax]);
}
