"use strict";

$(document).ready(function () {
  if (!localStorage.getItem("token")) {
    Swal.fire({
      title: "Please Login",
      text: "Go back to login page",
      icon: "warning",
    });
    setTimeout(() => {
      location.href = "../v/login.html";
    }, 3000);
  }

  getAllProducts();
  $(".addProdButton").click(function () {
    addProduct();
  });
  $(".deleteProdButton").click(function () {
    deleteProduct();
  });

  welcomeUser();
});

function getAllProducts() {
  $.ajax({
    url: "http://localhost/v/products/get_products.php",
    type: "GET",
    success: function (response) {

      renderProducts(response);
    },
    error: function (error) {
      console.log(error);
    },
  });
}

function renderProducts(data) {
  const dataObject = JSON.parse(data);
  const product_list = dataObject["data"];


  product_list.forEach((element) => {
    const html = `<tr><td>${element.product_id}</td>
    <td> ${element.product_name}</td>
    <td> ${element.category_type}</td>
    <td> ${element.price}</td>
    </tr>`;

    $(".tbody").prepend(html);
  });
}
function addProduct() {
  $.ajax({
    url: "http://localhost/v/products/add_products.php",
    type: "POST",
    data: {
      category_type: $(".categoryType").val(),
      product_name: $(".productName").val(),
      product_price: $(".productPrice").val(),
    },
    success: function (response) {

      const response_object = JSON.parse(response);

      if (response_object.status) {
        Swal.fire({
          title: "Success!",
          text: "Product added",
          icon: "success",
        });
        $("table .tbody tr").remove();
        renderSingleProduct(response_object);
        getAllProducts();
      } else {
        Swal.fire({
          title: "Failed!",
          text: "Product cannot be added",
          icon: "error",
        });
      }
    },
    error: function (error) {
      console.log(error);
    },
  });
}

function deleteProduct() {
  $.ajax({
    url: "../v/products/delete_product.php",
    method: "POST",
    data: {
      category_type: $(".categoryTypeRemove").val(),
      product_name: $(".productNameRemove").val(),
    },
    success: function (response) {
      const responseObject = JSON.parse(response);
      console.log(response);
      if (responseObject.status == true) {
        Swal.fire({
          title: "Deleted Product",
          icon: "success",
        });
        $("table .tbody tr").remove();
        getAllProducts();
      } else {
        Swal.fire({
          title: "Cannot Delete this Product try again",
          icon: "error",
        });
      }
    },
    error: function (error) {
      console.log(error);
    },
  });
}

function renderSingleProduct(data) {
  let html = `<tr>`;
  for (let i = 0; i < data.length; i++) {
    html += `<td>${data[i]}</td>`;
  }
  html += "</tr>";
  $(".tbody").prepend(html);
}

function welcomeUser() {
  $.ajax({
    url: "../v/products/get_user.php",
    method: "GET",
    headers: { token: localStorage.getItem("token") },
    success: function (response) {
      const responseData = JSON.parse(response);
      const userName = responseData.data["full_name"];
      Swal.fire({
        title: `Welcome ${userName}`,
        text: "click below to view products",
        icon: "success",
        confirmButtonText: "View Products",
      });
      console.log(response);
      $(".welcomeUser").append(" " + userName);
    },
    error: function (error) {
      console.log("failed");
      console.log(error);
    },
  });
}

$(".logout").click(function () {
  localStorage.removeItem("token");
  location.href = "../v/login.html";
});
