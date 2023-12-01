if (!localStorage.getItem("token")) {
    location.href = "./login.html";
}

$.ajax({
    url: "http://localhost/report_task/php_demo/api/getUser.php",
    type: "POST",
    data: {
        token: localStorage.getItem("token"),
    },
    success: (response) => {
        console.log(response);
        // response = JSON.parse(response);

        if (!response.status) {
            Swal.fire("Please Log In", response.message, "error");
            logout();
            return false;
        }
        let user = response.data;
        $("#userName").text(user.name);
    },
    error: () => {},
});
function loadProductData() {
    // Fetch product data from the server
    $.ajax({
      type: "GET",
      url: "http://localhost/report_task/php_demo/api/prop.php",
      success: function(products) {
        console.log(products);

        // Clear existing table rows
        $("#productTableBody").empty();

        // Append new table rows based on the fetched product data
        products.forEach(function(product) {
          var tableRow = `<tr>
         
          <td> <input type="checkbox" name="" id=""></td>
          <td><img src="${product['image_url']}" alt="Image" width=100 height=100></td>
            <td>${product.product_name}</td>
            <td>${product.category}</td>
            <td>${product.sku}</td>
            <td>${product.variant}</td>
            <td>${product.price}</td>
            <td>${product.status}</td>
          </tr>`;
          $("#productTableBody").append(tableRow);
        });
      },
      error: function(error) {
        console.error("Error:", error);
        // Handle error, e.g., show an alert
        // alert(",Error communicating with the server.");
      },
    });
  } 


function logout() {
    localStorage.removeItem("token");
    location.href = "./login.html";
}
document.getElementById("sidebarToggle").addEventListener("click", function () {
    document.getElementById("sidebarMenu").classList.toggle("collapsed");
});
