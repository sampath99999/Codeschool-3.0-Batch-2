<?php

require_once("../includes/dbconnect.php");
require_once("../includes/functions.php");

$categoryId = $_POST['category_id'];

try {
    if ($categoryId) {
        $stmt2 = $pdo->prepare("select * from product as p join category as c on p.category_id=c.id where p.category_id=?");
        $stmt2->execute([$categoryId]);
        $result2 = $stmt2->fetchAll(PDO::FETCH_ASSOC);
    } else {
        $stmt2 = $pdo->prepare("select * from product as p join category as c on p.category_id=c.id ");
        $stmt2->execute([]);
        $result2 = $stmt2->fetchAll(PDO::FETCH_ASSOC);
    }

    response(true, "Received Data Successfully!", $result2);

} catch (PDOException $e) {
    response(false, $e->getMessage());
}
