

$(document).ready(function () {
    loadProductData();
    $("#addForm").submit(function (event) {
        event.preventDefault();
        ajax_call();
    });
});

function getData() {
    const formData = {
        title: $("input[name='title']").val(),
        author: $("input[name='author']").val(),
        price: $("input[name='price']").val(),
    };
    console.log("Form Data:", formData);
    return formData;
}

function ajax_call() {
    $.ajax({
        type: "POST",
        url: "http://localhost/codeschool/php_demo/api/product.php",
        data: getData(),
        success: function (response) {
            console.log("success");
            loadProductData();
            console.log(response);
        },
        error: function (error) {
            console.error("Error:", error);
            alert(",Error communicating with the server.");
        },
    });
}

//---------Get Request --------------

function loadProductData() {
    // Fetch product data from the server
    $.ajax({
        type: "GET",
        url: "http://localhost/codeschool/php_demo/api/index.php",
        success: function (products) {
            console.log(products);

            // Clear existing table rows
            $("#products_table").empty();

            // Append new table rows based on the fetched product data
            products.forEach(function (product) {
                var tableRow = `<tr>
           
            <td>${product.title}</td>
            <td>${product.author}</td>
            <td>${product.price}</td>
          </tr>`;
                $("#products_table").append(tableRow);
            });
        },
        error: function (error) {
            // console.error("Error:", error);
            // Handle error, e.g., show an alert
            // alert(",Error communicating with the server.");
        },
    });
}
