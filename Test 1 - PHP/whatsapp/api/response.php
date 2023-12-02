<?php
function response($status = false, $message = "", $data = null)
{
    $response = [
        "status" => $status,
        "message" => $message,
        "data" => $data
    ];

    echo json_encode($response);
    exit();
}
// Example usage:
// response(true, 'Success', ['test', 'test', 'test']);
?>