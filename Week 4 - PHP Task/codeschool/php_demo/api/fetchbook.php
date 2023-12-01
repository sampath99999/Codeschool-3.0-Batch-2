<?php
// Connect to PostgreSQL database
$host = "localhost";
$dbname = "bookstore";
$user = "postgres";
$password = "postgres";


$db = new PDO("pgsql:host=$host;dbname=$dbname;user=$user;password=$password");

// Function to fetch all books or search for books
function fetchBooks($db, $searchTerm = null)
{
    if ($searchTerm !== null) {
        $stmt = $db->prepare("SELECT * FROM books WHERE title LIKE :searchTerm OR author LIKE :searchTerm");
        $stmt->bindValue(':searchTerm', "%$searchTerm%", PDO::PARAM_STR);
        $stmt->execute();
    } else {
        $stmt = $db->query("SELECT * FROM books");
    }

    $books = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (count($books) > 0) {
        // echo "<table border='1'>";
        // echo "<tr><th>ID</th><th>Title</th><th>Author</th><th>Price</th></tr>";
        // foreach ($books as $book) {
        //     echo "<tr>
        //     <td>{$book['book_id']}</td>
        //     <td>{$book['title']}</td>
        //     <td>{$book['author']}</td>
        //     <td>{$book['price']}</td></tr>";
        // }
        // echo "</table>";

        echo "<div class='row w-100 flex-wrap' >";
        foreach ($books as $book) {
            echo "<div class='container  justify-content-center align-items-center'>
    <div class='col-md-6'>
        <div class='card mb-4 shadow-sm' style='width:100%'>
        <img src={$book['image']} class='card-img-top' alt='...' style='width:100% ,height:200px' ;>
            <div class='card-body'>
                <p class='card-text'><strong>Title:</strong> {$book['book_id']}</p>
                <p class='card-text'><strong>Title:</strong> {$book['title']}</p>
                <p class='card-text'><strong>Author:</strong> {$book['author']}</p>
                <p class='card-text'><strong>Price:</strong> {$book['price']}</p>
                <button type='submit' class='btn btn-primary' onClick='addToCart()'>Add</button>
            </div>
        </div>
    </div>
    </div>";
        }
        echo "</div>";
    } else {
        echo "No books found.";
    }
}

// Fetch books based on search term
if (isset($_GET['search'])) {
    $searchTerm = $_GET['search'];
    fetchBooks($db, $searchTerm);
} else {
    // Fetch all books by default
    fetchBooks($db);
}
