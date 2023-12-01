if (localStorage.getItem("token")) {
    location.href = "./browse.html";
}

function searchData() {
    var searchValue = document.getElementById("search").value;
    var token = localStorage.getItem("token");

    $.ajax({
        type: "POST",
        url: "http://localhost/codeschool/php_demo/api/browse.php",
        data: { token: token, search: searchValue },
        success: function (response) {
            $("#searchResults").html(response.message);
            // Handle the results as needed
        },
        error: function (error) {
            console.log(error);
        },
    });
}
