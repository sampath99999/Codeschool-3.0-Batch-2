<?php

require_once("./dbconnect.php");
require_once("./response.php");

$search = $_POST['search'];

try {
    if ($search) {
        $pattern = '%' . $search . '%';
        $stmt2 = $pdo->prepare("select * from image where image_name ilike :pattern");
        $stmt2->bindParam('pattern', $pattern);
        $stmt2->execute();
        $result2 = $stmt2->fetchAll(PDO::FETCH_ASSOC);
    }
    response(true, "Received Data Successfully!", $result2);

} catch (PDOException $e) {
    response(false, $e->getMessage());
}
