<?php
require_once("response.php");
require_once("db_connect.php");
require_once("functions.php");

// Function to return  a simple bot response
function getBotResponse($userMessage) {
    
    return "Bot: Hi there! You said: " . $userMessage;
}


if (isset($_POST['message'])) {
    
    $userMessage = $_POST['message'];

    
    $botResponse = getBotResponse($userMessage);

    // Return the bot response as JSON
    echo json_encode(['botMessage' => $botResponse]);
} else {
    // Return an error message if 'message' parameter is not set
    echo json_encode(['error' => 'Message parameter not set']);
}

?>
