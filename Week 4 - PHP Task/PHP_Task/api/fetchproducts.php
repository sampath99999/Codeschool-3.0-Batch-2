<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

require_once("./../utils/db.php");
require_once("./../utils/functions.php");
include("./../utils/vaish.php");


$host = "localhost";
$dbname = "phptask";
$user = "postgres";
$password = "postgres";


$db = new PDO("pgsql:host=$host;dbname=$dbname;user=$user;password=$password");


function fetchproducts($db, $searchTerm = null)
{
    if ($searchTerm !== null) {
        $stmt = $db->prepare("SELECT * FROM listing WHERE title LIKE :searchTerm OR description LIKE :searchTerm");
        $stmt->bindValue(':searchTerm', "%$searchTerm%", PDO::PARAM_STR);
        $stmt->execute();
    } else {
        $stmt = $db->query("SELECT * FROM listing");
    }

    $listing = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (count($listing) > 0) {
        
        echo "<div class='row w-100 flex-wrap' >";
        foreach ($listing as $listings) {
            echo "<div class='container d-flex flex-wrap justify-content-center align-items-center'>
    <div class='col-md-12'>
        <div class='card mb-4 shadow-sm' style='width:100%'>
        <img src={$listings['url']} class='card-img-top' alt='...' style='width:100% ,height:200px' ;>
            <div class='card-body'>
                <p class='card-text'><strong>Title:</strong> {$listings['id']}</p>
                <p class='card-text'><strong>Title:</strong> {$listings['title']}</p>
                <p class='card-text'><strong>Author:</strong> {$listings['description']}</p>
                <p class='card-text'><strong>Price:</strong> {$listings['price']}</p>
                <p class='card-text'><strong>Price:</strong> {$listings['mode']}</p>
                <p class='card-text'><strong>Price:</strong> {$listings['sellername']}</p>
                <p class='card-text'><strong>Price:</strong> {$listings['phone']}</p>
                
                <button type='submit' class='btn btn-primary' onclick='deletefromcart()'>Delete</button>
            </div>
        </div>
    </div>
    </div>";
        }
        echo "</div>";
    } else {
        echo "No products found.";
    }
}


if (isset($_GET['search'])) {
    $searchTerm = $_GET['search'];
    fetchproducts($db, $searchTerm);
} else {
    
    fetchproducts($db);
}
