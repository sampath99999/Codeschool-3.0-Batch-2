<?php

require_once("../Database/functions.php");
require_once("../Database/dbconnection.php");


if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}
if (!isset($_POST["first_name"])) {
    response("First Name needed!");
}
if (!isset($_POST["last_name"])) {
    response("Last Name is required!");
}
if (!isset($_POST["doj"])) {
    response("Date of joining is required!");
}
if (!isset($_POST["dob"])) {
    response("Date of birth is required!");
}if (!isset($_POST["gender"])) {
    response("Gender is required!");
}if (!isset($_POST["phone"])) {
    response("Phone is required!");
}if (!isset($_POST["working_status"])) {
    response("Working status is required!");
}if (!isset($_POST["designation"])) {
    response("Designation is required!");
}if (!isset($_POST["location"])) {
    response("Location is required!");
}
$token=$_POST["token"];




$pdo = getPDO();



$query = "SELECT * FROM users where token = :token ";
$stmt = $pdo->prepare($query);
$stmt->bindParam("token", $token);

$stmt->execute();


$user = $stmt->fetch(PDO::FETCH_ASSOC);

$key= $user["ddocode"];


$first_name = $_POST["first_name"];
$last_name = $_POST["last_name"];
$doj = $_POST["doj"];
$dob = $_POST["dob"];
$gender = $_POST["gender"];
$phone = $_POST["phone"];
$working_status = $_POST["working_status"];
$designation = $_POST["designation"];
$location = $_POST["location"];
$ddocode = $key;



$query= "INSERT INTO employee_details (first_name, last_name, doj, dob, gender, phone, working_status, designation, location, ddocode) VALUES (:first_name, :last_name, :doj, :dob,:gender , :phone, :working_status, :designation, :location, :ddocode)";
$stmt = $pdo->prepare($query);
$stmt->bindParam("first_name", $first_name);
$stmt->bindParam("last_name", $last_name);  
$stmt->bindParam("doj", $doj);
$stmt->bindParam("dob", $dob);  
$stmt->bindParam("gender", $gender);
$stmt->bindParam("phone", $phone);  
$stmt->bindParam("working_status", $working_status);
$stmt->bindParam("designation", $designation);
$stmt->bindParam("location", $location);
$stmt->bindParam("ddocode", $ddocode);
$stmt->execute();

if ($stmt->rowCount() != 0) {
    response("Registered Successfully!", true);
} else {response("something went wrong",false);}
?>