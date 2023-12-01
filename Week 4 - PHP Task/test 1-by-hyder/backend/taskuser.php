<?php
header('Content-Type: application/json');
require_once("cors.php");
include("functions.php");
require_once("connectiondb.php");

// Check for POST method
if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

// Validate required fields for a task
if (!isset($_POST["email"])) {
    response("Email is required!");
}

// Assign values
$email = $_POST["email"];

// Obtain PDO instance
$pdo = getPDO();

try {
    // Retrieve UserID based on email
    $query = "SELECT UserID, userid FROM t_Users WHERE email = :email";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":email", $email, PDO::PARAM_STR);
    $stmt->execute();

    // Check if the user was found
    if ($stmt->rowCount() > 0) {
        
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $userID = isset($row["UserID"]) ? $row["UserID"] : $row["userid"];

        // Selecting task and user information
        try {
                $query = "SELECT
                t.taskname,
                ts.statusname,
                t.createdbyuserid,
                CONCAT(u.first_name, ' ', u.last_name) AS creator_name
            FROM
                t_Users u
            JOIN
                Tasks t ON u.UserID = t.CreatedByUserID OR u.UserID = t.AssignedToUserID
            JOIN
                TaskStatus ts ON t.StatusID = ts.StatusID
            WHERE
                u.userid=:userID";

            $stmt = $pdo->prepare($query);
            $stmt->bindParam(":userID", $userID, PDO::PARAM_INT);
            $stmt->execute();
            $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if ($results) {
                echo json_encode(array(
                    "status" => true,
                    "message" => "Task information retrieved successfully",
                    "data" => $results
                ));
            } else {
                echo json_encode(array(
                    "status" => false,
                    "message" => "No tasks found for the specified user",
                    "data" => null
                ));
            }
            
        } catch (Exception $e) {
            response("Something went wrong: " . $e->getMessage());
        }
    } else {
        response("User not found for the specified email", false);
    }
} catch (Exception $e) {
    response("Something went wrong: " . $e->getMessage());
}
?>
