<?php
require_once("functions.php");
require_once("cors.php");
require_once("connectiondb.php");

if ($_SERVER["REQUEST_METHOD"] !== "GET") {
    response("Only GET method is accepted");
}

// Validate required fields
if (!isset($_GET["employee_code"]) || !isset($_GET["ddo_code"]) || !isset($_GET["month"]) || !isset($_GET["year"])) {
    response("All fields are required!");
}

// Assign values
$employee_code = $_GET["employee_code"];
$ddo_code = $_GET["ddo_code"];
$month = $_GET["month"];
$year = $_GET["year"];

// Obtain PDO instance
$pdo = getPDO();
try {
    // Check if the salary already exists with the given details
    $query = "SELECT 
        e.employee_code,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        SUM(CASE WHEN edl.name = 'bp' THEN eed.amount ELSE 0 END) AS basic_pay,
        SUM(CASE WHEN edl.name = 'da' THEN eed.amount ELSE 0 END) AS da,
        SUM(CASE WHEN edl.name = 'hra' THEN eed.amount ELSE 0 END) AS hra,
        SUM(CASE WHEN edl.name = 'cca' THEN eed.amount ELSE 0 END) AS cca,
        SUM(CASE WHEN edl.name = 'insurance' THEN eed.amount ELSE 0 END) AS insurance,
        SUM(CASE WHEN edl.name = 'pt' THEN eed.amount ELSE 0 END) AS pt,
        SUM(CASE WHEN edl.name = 'Pf' THEN eed.amount ELSE 0 END) AS pf,
        COALESCE(SUM(eed.amount), 0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END), 0) as deduction,
        COALESCE(SUM(eed.amount), 0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END), 0) as net,
        CASE WHEN COALESCE(SUM(eed.amount), 0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM 
        employee_details e
    JOIN 
        employee_earn_deduction eed ON e.employee_code = eed.employee_code
    JOIN 
        earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE 
        edl.name IN ('bp', 'da', 'hra', 'cca', 'insurance', 'pt', 'Pf') AND
        EXTRACT(YEAR FROM eed.with_effect_date) = :year AND
        EXTRACT(MONTH FROM eed.with_effect_date) = :month AND
        e.employee_code = :employee_code AND
        e.ddo_code = :ddo_code
    GROUP BY 
        e.employee_code, CONCAT(e.first_name, ' ', e.last_name)";

    // Prepare and execute the SQL query
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":employee_code", $employee_code, PDO::PARAM_STR);
    $stmt->bindParam(":ddo_code", $ddo_code, PDO::PARAM_STR);
    $stmt->bindParam(":month", $month, PDO::PARAM_INT);
    $stmt->bindParam(":year", $year, PDO::PARAM_INT);
    $stmt->execute();

    // Fetch salary details
    $salaryDetails = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($salaryDetails) {
        // Respond with success and data
        response("Salary details fetched", true, $salaryDetails);
    } else {
        response("No salary details found");
    }

} catch (Exception $e) {
    // Log the error and respond with an appropriate error message
    error_log("Error: " . $e->getMessage());
    response("Something went wrong. Please try again later.", false);
}
?>
