function render_employee(items) {
    $('.tbody tr').remove();

    let employee_list = items;
    console.log(employee_list);
    employee_list.forEach((ele) => {
        let product_name = ele['product_name'];
        let product_description = ele['product_description'];

        let product_image = ele['product_image'];
        let product_price = ele['product_price'];
        let product_rating = ele['product_rating'];


        const body = document.querySelector('.tbody');
        const html = `<tr class="m-3" onclick="detail($product_name,$product_description,$product_image,$product_price,)"><td class="p-3"><img src="${product_image}" style="width: 20px;height:20px;">  ${product_name} <br>${product_description} <br> Rs  ${product_price} <br> ${product_rating}</td><br></tr>`;

        $('.tbody').append(html);
    });

}
$(document).ready(function() {
    // if (!localStorage.getItem(token)) {
    //     location.href = "./login.html";
    // }
    var token = localStorage.getItem(token);

    var token = localStorage.getItem("token");
    var url = "../Api/products.php";

    $.ajax({
        type: "POST",
        url: url,
        data: {
            token: token
        },
        datatype: "JSON",
        success: function(response) {
            response = JSON.parse(response);

            console.log(response);
            // Handle the response from the server as needed
            if (response.status) {

                render_employee(response.data);
            } else {

                alert("Error submitting salary details. Please try again.");
            }
        },
        error: function(error) {
            console.error(error);
            // Handle AJAX error, e.g., show an error message
            alert("Error submitting salary details. Please try again.");
        }
    });



});