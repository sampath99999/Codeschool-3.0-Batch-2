<?php

require_once("../Database/functions.php");
require_once("../Database/dbconnection.php");


if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["employee_code"])) {
    response("Employee code needed!");
}
if (!isset($_POST["earning_type"])) {
    response("Earning type needed!");
}if (!isset($_POST["amount"])) {
    response("Amount is needed!");
}
if (!isset($_POST["earning_date"])) {
    response("Earning Date needed!");
}if (!isset($_POST["deduction_type"])) {
    response("Deduction type is needed!");
}

if (!isset($_POST["damount"])) {
    response("Deduction amount needed!");
}
if (!isset($_POST["deduction_date"])) {
    response("Deduction Date is  needed!");
}
$employee_code=$_POST["employee_code"];
$earning_type=$_POST["earning_type"];
$amount=$_POST["amount"];
$earning_date=$_POST["earning_date"];
$deduction_type=$_POST["deduction_type"];
$deduction_amount=$_POST["damount"];
$deduction_date=$_POST["deduction_date"];$pdo = getPDO();


$query= "INSERT INTO earnings (employee_code,earning_type,amount,earning_date) VALUES (:employee_code, :earning_type,:amount,:earning_date)";
$stmt = $pdo->prepare($query);
$stmt->bindParam("employee_code", $employee_code);
$stmt->bindParam("earning_type", $earning_type);  
$stmt->bindParam("amount", $amount);
$stmt->bindParam("earning_date", $earning_date);  

$stmt->execute();

$query= "INSERT INTO deductions (employee_code,deduction_type,damount,deduction_date) VALUES (:employee_code, :deduction_type,:deduction_amount,:deduction_date)";
$stmt = $pdo->prepare($query);
$stmt->bindParam("employee_code", $employee_code);
$stmt->bindParam("deduction_type", $deduction_type);  
$stmt->bindParam("deduction_amount", $deduction_amount);
$stmt->bindParam("deduction_date", $deduction_date);  

$stmt->execute();


if ($stmt->rowCount() != 0) {
    response("Registered Successfully!", true);
} else {response("something went wrong",false);}
?>