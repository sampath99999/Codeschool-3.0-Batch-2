<?php 

require_once("../Database/functions.php");
require_once("../Database/dbconnection.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

$employee_code=$_POST["employeecode"];



$pdo = getPDO();


$query = "SELECT DISTINCT *
FROM earnings
JOIN deductions ON earnings.employee_code = deductions.employee_code
where earnings.employee_code = :employee_code AND deductions.employee_code=:employee_code;

";
$stmt = $pdo->prepare($query);
$stmt->bindParam("employee_code", $employee_code);

$stmt->execute();



$datas = $stmt->fetchAll(PDO::FETCH_ASSOC);
response(true,"sucessfull",$datas);