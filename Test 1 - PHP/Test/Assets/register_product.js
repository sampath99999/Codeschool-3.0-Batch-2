function product_register() {
    if (!localStorage.getItem("token")) {
        location.href = "./login.html";
    }
    var product_name = $('#product_name').val();
    var product_description = $('#product_description').val();
    var product_image = $('#product_image').val();
    var product_price = $('#product_price').val();
    var product_rating = $('#product_rating').val();
    var token = localStorage.getItem('token');
    console.log(product_name);
    console.log(product_description);
    console.log(product_image);
    console.log(product_price);
    console.log(product_rating);
    console.log(token);

    var data = {
        product_name: product_name,
        product_description: product_description,
        product_image: product_image,
        product_price: product_price,
        product_rating: product_rating,
        token: token


    };

    // Make AJAX call
    $.ajax({
        type: 'POST', // You can change this to 'GET' or 'PUT' depending on your backend
        url: '../Api/register_product.php', // Replace with your actual backend API endpoint

        data: data,
        success: function(response) {
            // Handle successful registration response
            console.log('successfully');
        },
        error: function(error) {
            // Handle registration error
            console.error('Error registering product:', error);
        }
    });
}