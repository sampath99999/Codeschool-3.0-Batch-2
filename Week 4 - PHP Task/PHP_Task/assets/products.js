$(document).ready(function () {
   
    function logout() {
        localStorage.removeItem("token");
        location.href = "./../login.html";
    }

    function submitForm() {
        let url = $("#url").val();
        let title = $("#title").val();
        let description = $("#description").val();
        let price = $("#price").val();
        let mode = $("#mode").val();
        let sellername = $("#sellername").val();
        let phone = $("#phone").val();


        $.ajax({
            url: "http://localhost/PHP_Task/api/products.php",
            type: "POST",
            data: {
                url,
                title,
                description,
                price,
                mode,
                sellername,
                phone
            },
            success: function (response) {
                console.log(response);
                try {
                    //response = JSON.parse(response);
                    if (response.status) {
                        alert("Data added successfully!");
                        location.href = "./../dashboard.html";
                    } else {
                        alert("Failed to add data. " + response.message);
                    }
                } catch (error) {
                    console.error("Error parsing JSON:", error);
                    alert("Unexpected error occurred.");
                }
            },
            error: function () {
                console.error("Error in AJAX request.");
                alert("Error in communication with the server.");
            },
        });
    }

 
    $("#button1").submit(function (event) {
        event.preventDefault(); 
        submitForm();
    });
});


function loadProductData() {
    $.ajax({
        type: "GET",
        url: "http://localhost/PHP_Task/api/dashboard.php",
        success: function (books) {
            console.log(books);
            $("#productTableBody").empty();
            books.forEach(function (product) {
                var tableRow = `<tr>
                   <td>${product.url}</td>
                    <td>${product.title}</td>
                    <td>${product.description}</td>
                    <td>${product.price}</td>
                    <td>${product.mode}</td>
                    <td>${product.sellername}</td>
                    <td>${product.phone}</td>
                  </tr>`;
                $("#productTableBody").append(tableRow);
            });
        },
        error: function (error) {
            console.error("Error:", error);
            alert(",Error communicating with the server.");
        },
    });
}