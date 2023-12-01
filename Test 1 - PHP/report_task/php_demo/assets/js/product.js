$(document).ready(function() {
loadProductData();
$("#productForm").submit(function(event) {
    event.preventDefault();
    ajax_call();
})
})

function getData() {
    const formData = {
        image_url:$("input[name='image']").val(),
        product_name: $("input[name='product_name']").val(),
        category: $("input[name='category']").val(),
        sku:$("input[name='sku']").val(),
        variant:$("input[name='variant']").val(),
        price: $("input[name='price']").val(),
        status: $("input[name='status']").val(),
        
       
      };
      console.log("Form Data:", formData);
      return formData;
    }
    // AJAX request
    function ajax_call(){
    $.ajax({
        type: "POST",
        url: "http://localhost/report_task/php_demo/api/pushData.php",
        data: getData(),
        success: function(response) {
          console.log(response);
          loadProductData();
        },
        error: function(error) {
            console.error("Error:", error);
            // alert(",Error communicating with the server.");
        },
    })}
    
        
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
              <td><img src="${product.image_url}" alt="Image" width=100 height=100></td>
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
  
  
function searchData() {
  var searchValue = document.getElementById("search").value;
  var token = localStorage.getItem("token");

  $.ajax({
      type: "POST",
      url: "http://localhost/report_task/php_demo/api/browse.php",
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