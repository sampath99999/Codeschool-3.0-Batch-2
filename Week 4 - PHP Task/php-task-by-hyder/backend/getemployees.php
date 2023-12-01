<?php
require_once("cors.php");
require_once("functions.php");
require_once("connectiondb.php");

// Check if the "username" key exists in the $_GET array
if (isset($_GET["username"])) {
    $username = $_GET["username"];
    $pdo = getPDO();

    $query = "SELECT
            e.employee_code,
            CONCAT(e.first_name, ' ', e.last_name) AS name,
            e.date_of_join AS doj,
            e.date_of_birth AS dob,
            e.gender,
            e.phone,
            w.status,
            d.designation,
            l.city_name
            FROM
            employee_details e
            JOIN
            users u ON e.ddo_code = u.ddo_code
            JOIN
            working_status w ON e.working_status = w.id
            JOIN
            designation d ON e.designation = d.id
            JOIN
            location l ON e.location = l.id
            WHERE
            e.ddo_code = :username";

    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":username", $username, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        $userDetails = $stmt->fetchAll(PDO::FETCH_ASSOC);
        response("User details retrieved successfully", true, ["userDetails" => $userDetails]);
    } else {
        response("No data found for the user!");
    }
} else {
    // Handle the case when "username" is not set in the request
    response("Username not provided in the request!");
}

header('Content-Type: application/json');
echo json_encode($products);
?>
