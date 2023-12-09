<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

require_once("./../utils/db.php");
require_once("./../utils/functions.php");
include("./../utils/vaish.php");

$host = "localhost";
$dbname = "test1";
$user = "postgres";
$password = "postgres";

$db = new PDO("pgsql:host=$host;dbname=$dbname;user=$user;password=$password");

function fetchProducts($db, $searchTerm = null)
{
    if ($searchTerm !== null) {
        $stmt = $db->prepare("SELECT * FROM productslisting WHERE title LIKE :searchTerm OR description LIKE :searchTerm");
        $stmt->bindValue(':searchTerm', "%$searchTerm%", PDO::PARAM_STR);
        $stmt->execute();
    } else {
        $stmt = $db->query("SELECT * FROM productslisting");
    }

    $productListing = $stmt->fetchAll(PDO::FETCH_ASSOC);

    return $productListing;
}

if (isset($_GET['search'])) {
    $searchTerm = $_GET['search'];
    $products = fetchProducts($db, $searchTerm);
} else {
    $products = fetchProducts($db);
}

echo json_encode(["status" => true, "data" => $products]);

exit();
?>
