<?php

include("./utils/cors.php");
require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

// echo $_POST["phone"];
var_dump($_POST);
exit();
// Validate and retrieve POST data
if (!isset($_POST["name"])) {
    response("Name is required!");
}
if (!isset($_POST["email"])) {
    response("Email is required!");
}
if (!isset($_POST["phone"])) {
    response("Phone is required!");
}
if (!isset($_POST["customAmount"])) {
    response("Amount is required!");
}
if (!isset($_POST["cardNumber"])) {
    response("Card Number is required!");
}
if (!isset($_POST["expiryDate"])) {
    response("Expiry Date is required!");
}
if (!isset($_POST["cvv"])) {
    response("CVV is required!");
}

$name = $_POST["name"];
$email = $_POST["email"];
$phone = $_POST["phone"];
$amount = $_POST["customAmount"];
$cardNumber = $_POST["cardNumber"];
$expiryDate = $_POST["expiryDate"];
$cvv = $_POST["cvv"];


$pdo = getPDO();


// $query = "SELECT * FROM donations WHERE user_id = :user_id ";
// $stmt = $pdo->prepare($query);
// $stmt->bindParam("user_id", $user_id, PDO::PARAM_INT);
// $stmt->execute();

// if ($stmt->rowCount() > 0) {
//     response("Donation already exists for this user and timestamp");
// }

// Insert donation
$query = "INSERT INTO donations ( name, email, phone, amount, card_number, expiry_date, cvv) 
          VALUES ( :name, :email, :phone, :amount, :cardNumber, :expiryDate, :cvv)";
$stmt = $pdo->prepare($query);
// $stmt->bindParam("user_id", $user_id, PDO::PARAM_INT);
$stmt->bindParam("name", $name, PDO::PARAM_STR);
$stmt->bindParam("email", $email, PDO::PARAM_STR);
$stmt->bindParam("phone", $phone, PDO::PARAM_STR);
$stmt->bindParam("amount", $amount, PDO::PARAM_STR);
$stmt->bindParam("cardNumber", $cardNumber, PDO::PARAM_STR);
$stmt->bindParam("expiryDate", $expiryDate, PDO::PARAM_STR);
$stmt->bindParam("cvv", $cvv, PDO::PARAM_STR);

$stmt->execute();

if ($stmt->rowCount() != 0) {
    response("Donation Added Successfully!", true);
}

response("Something went wrong!");
