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
if (!isset($_POST["task_name"]) || !isset($_POST["created_by_user_id"]) || !isset($_POST["assigned_to_user_id"]) || !isset($_POST["status_id"])) {
    response("All fields are required for a task!");
}

// Assign values
$task_name = $_POST["task_name"];
$created_by_user_id = $_POST["created_by_user_id"];
$assigned_to_user_id = $_POST["assigned_to_user_id"];
$status_id = $_POST["status_id"];

// Obtain PDO instance
$pdo = getPDO();

try {
    // Inserting task data
    $query = "INSERT INTO Tasks (TaskName, CreatedByUserID, AssignedToUserID, StatusID) VALUES (:task_name, :created_by_user_id, :assigned_to_user_id, :status_id)";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(":task_name", $task_name, PDO::PARAM_STR);
    $stmt->bindParam(":created_by_user_id", $created_by_user_id, PDO::PARAM_INT);
    $stmt->bindParam(":assigned_to_user_id", $assigned_to_user_id, PDO::PARAM_INT);
    $stmt->bindParam(":status_id", $status_id, PDO::PARAM_INT);
    $stmt->execute();

    response("Task added successfully", true);
} catch (Exception $e) {
    response("Something went wrong: " . $e->getMessage());
}
?>
