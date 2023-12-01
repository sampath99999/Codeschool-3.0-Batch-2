<?php
require_once("functions.php");
require_once("cors.php");
require_once("connectiondb.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method is accepted");
}

// Validate required fields
if (!isset($_POST["employee_code"]) || !isset($_POST["earn_deduction_id"]) || !isset($_POST["amount"]) || !isset($_POST["with_effect_date"])) {
    response("All fields are required!");
}

// Assign values
$employee_code = $_POST["employee_code"];
$earn_deduction_id = $_POST["earn_deduction_id"];
$amount = $_POST["amount"];
$with_effective_date = $_POST["with_effect_date"];

// Obtain PDO instance
$pdo = getPDO();
try {
    // Check if the salary already exists with the given details
    $query = "SELECT * FROM employee_earn_deduction WHERE employee_code = :employee_code AND earn_deduction_id = :earn_deduction_id AND amount = :amount AND with_effect_date = :with_effect_date";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":employee_code", $employee_code, PDO::PARAM_STR);
    $stmt->bindParam(":earn_deduction_id", $earn_deduction_id, PDO::PARAM_STR);
    $stmt->bindParam(":amount", $amount, PDO::PARAM_STR);
    $stmt->bindParam(":with_effect_date", $with_effective_date, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        response("Salary already exists with the given details");
    }

    // Inserting data
    $query = "INSERT INTO employee_earn_deduction (employee_code, earn_deduction_id, amount, with_effect_date) VALUES (:employee_code, :earn_deduction_id, :amount, :with_effect_date)";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":employee_code", $employee_code, PDO::PARAM_STR);
    $stmt->bindParam(":earn_deduction_id", $earn_deduction_id, PDO::PARAM_STR);
    $stmt->bindParam(":amount", $amount, PDO::PARAM_STR);
    $stmt->bindParam(":with_effect_date", $with_effective_date, PDO::PARAM_STR);
    $stmt->execute();

    response("Salary Added", true);
} catch (Exception $e) {
    // Log the error and respond with an appropriate error message
    error_log("Error: " . $e->getMessage());
    response("Something went wrong. Please try again later.", false);
}
?>
