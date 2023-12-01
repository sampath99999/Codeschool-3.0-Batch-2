<?php

require_once("./utils/functions.php");
require_once("./utils/db.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    response("Only POST method accepted!");
}

if (!isset($_POST["theaterId"])) {
    response("Theater ID is required!");
}

$theaterId = $_POST["theaterId"];

$pdo = getPDO();

$query = "DELETE FROM theaters WHERE theater_id = :theaterId";
$stmt = $pdo->prepare($query);
$stmt->bindParam(":theaterId", $theaterId, PDO::PARAM_INT);

if ($stmt->execute()) {
    response("Theater deleted successfully", true);
} else {
    response("Failed to delete theater", false);
}
