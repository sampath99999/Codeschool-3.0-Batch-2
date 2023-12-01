<?php
require_once("functions.php");
require_once("cors.php");
require_once("connectiondb.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method is accepted");
}

// Validate required fields
if (!isset($_POST["employee_code"]) || !isset($_POST["first_name"]) || !isset($_POST["last_name"]) || !isset($_POST["doj"]) || !isset($_POST["dob"]) 
    || !isset($_POST["gender"]) || !isset($_POST["phone"]) || !isset($_POST["w_id"]) || !isset($_POST["d_id"]) 
    || !isset($_POST["l_id"]) || !isset($_POST["ddo_code"])) {
    response("All fields are required!");
}

// Assign values
$employee_code = $_POST["employee_code"];
$first_name = $_POST["first_name"];
$last_name = $_POST["last_name"];
$doj = $_POST["doj"];
$dob = $_POST["dob"];
$gender = $_POST["gender"];
$phone = $_POST["phone"];
$w_id = $_POST["w_id"];
$d_id = $_POST["d_id"];
$l_id = $_POST["l_id"];
$ddo_code = $_POST["ddo_code"];

// Obtain PDO instance
$pdo = getPDO();
try {
    $query = "SELECT * FROM employee_details WHERE employee_code = :employee_code";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":employee_code", $employee_code, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        response("employee code already exists");
    }

    // Inserting data
    $query = "INSERT INTO employee_details (employee_code,first_name,last_name,date_of_join,date_of_birth,gender,phone,working_status,designation,location,ddo_code)
             VALUES (:employee_code, :first_name, :last_name, :doj, :dob, :gender, :phone, :w_id, :d_id, :l_id, :ddo_code)";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":employee_code", $employee_code, PDO::PARAM_STR);
    $stmt->bindParam(":first_name", $first_name, PDO::PARAM_STR);
    $stmt->bindParam(":last_name", $last_name, PDO::PARAM_STR);
    $stmt->bindParam(":doj", $doj, PDO::PARAM_STR);
    $stmt->bindParam(":dob", $dob, PDO::PARAM_STR);
    $stmt->bindParam(":gender", $gender, PDO::PARAM_STR);
    $stmt->bindParam(":phone", $phone, PDO::PARAM_STR);
    $stmt->bindParam(":w_id", $w_id, PDO::PARAM_STR);
    $stmt->bindParam(":d_id", $d_id, PDO::PARAM_STR);
    $stmt->bindParam(":l_id", $l_id, PDO::PARAM_STR);
    $stmt->bindParam(":ddo_code", $ddo_code, PDO::PARAM_STR);
    $stmt->execute();

    response("Insertion successful", true);
} catch (Exception $e) {
    // Log the error and respond with an appropriate error message
    error_log("Error: " . $e->getMessage());
    response("Something went wrong. Please try again later.", false);
}
?>
