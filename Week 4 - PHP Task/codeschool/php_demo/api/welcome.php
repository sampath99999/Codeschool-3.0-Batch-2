<?php
include("./utils/cors.php");
require("./utils/functions.php");

if (!isset($_GET["name"])) {
    response("Name is required!");
}

// Get Data
$name = $_GET["name"];

// Validations  
if (strlen($name) < 3 || strlen($name) > 25) {
    response("Name should be at least 3 characters or at most 25 characters");
}

echo json_encode(["status" => true, "message" => "Welcome, $name", "data" => null]);
