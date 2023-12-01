$(document).ready(function () {
    loadProductData();
    $("#productForm").submit(function (event) {
        event.preventDefault();
        ajax_call();
    });
});

function getData() {
    const formData = {
        image: $("input[name='image']").val(),
        title: $("input[name='title']").val(),
        author: $("input[name='author']").val(),
        price: $("textarea[name='price']").val(),
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
            if (response.status == true) {
                loadProductData();
                Swal.fire({
                    title: "Good job!",
                    text: "Data added successfully",
                    icon: "success",
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Name already exists",
                    text: "Change the Name",
                    footer: '<a href="#">Why do I have this issue?</a>',
                });
            }
        },
        error: function (error) {
            console.error("Error:", error);
        },
    });
}
function loadProductData() {
    $.ajax({
        type: "GET",
        url: "http://localhost/codeschool/php_demo/api/index.php",
        success: function (books) {
            console.log(books);
            $("#productTableBody").empty();
            books.forEach(function (product) {
                var tableRow = `<tr>
                   <td>${product.image}</td>
                    <td>${product.title}</td>
                    <td>${product.author}</td>
                    <td>${product.price}</td>
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
