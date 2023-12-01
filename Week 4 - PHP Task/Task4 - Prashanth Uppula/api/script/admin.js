let product = [];
let category = [];

let productName;
let userInfo;
userInfo = localStorage.getItem('users');
users = JSON.parse(userInfo);

$('#greeting').text(`${users.username.replace(/\b\w/g, l => l.toUpperCase())} !`);

if(!userInfo){
    alert("Please Login, Redirecting You...");
    window.location.replace("http://localhost/CodeSchool/Task4/login.html");
}else if(users.user_types_id != 1){
    alert("You do not have Admin Access, Redirecting You...");
    window.location.replace("http://localhost/CodeSchool/Task4/index.html");
}

$.ajax({
    url: "./api/cards.php",
    method: 'GET',
    dataType: 'json',
    success: function (response) {
      category = response.data.category
      product = response.data.product
  
      showCategories(category)
      showProducts(product)
  
    },
    error: function (status) {
      console.log('Request failed with status: ' + status);
    }
  });
  
  function showCategories(category) {
    $('#filterByCategory').empty();
    $('#filterByCategory').append(`
          <option><a class="dropdown-item" href="#">Select a Filter</a></option>
      `)
    for (let i = 0; i < category.length; i++) {
      $('#filterByCategory').append(`
          <option value="${category[i].id}"><a class="dropdown-item" style="text-transform: capitalize;">${category[i].categoryname.replace(/\b\w/g, l => l.toUpperCase())}</a></option>
      `)
    }
  }
  
  function showProducts(product) {
    $('#productData').empty();
    for (let i = 0; i < product.length; i++) {
      $('#productData').append(`
          <div class="col-3">
            <div class="ms-3">
            <div class="card mt-5 px-4 border-2 shadow-lg justify-content-center overflow-hidden" style="width: 20rem; height: 25rem">
                <img src="${product[i].image}" class="card-img-top mt-5 h-50" alt="Broken Link" style="object-fit: contain"/>
                <div class="card-body d-flex flex-column align-items-center">
                  <h5 class="card-title mt-1 fs-4 fw-bolder text-center">${product[i].name}</h5>
                  <p class="card-text mt-1 mb-3">
                    <span class="fs-5 ps-1">&#8377; ${product[i].price}</span>
                  </p>
                  <a href="#" class="btn btn-secondary pb-5" onclick="addToCart(${i})">Add to Cart</a>
                </div>
              </div>
            </div>
          </div>
      `)
    };
  }
  
  function filterProduct() {
    let selection = {
      category_id: $('#filterByCategory').val()
    }
  
    $.ajax({
      url: "./api/filterProducts.php",
      method: 'POST',
      dataType: 'json',
      data: selection,
      success: function (response) {
        products = response.data
        showProducts(response.data)
      },
      error: function (status) {
        console.log('Error Occurred: ' + status);
      }
    });
  }

function signout(){
    localStorage.removeItem('user');
    localStorage.removeItem('token');
    alert("Logged Out Successfully!");
    window.location.replace('http://localhost/CodeSchool/Task4/index.html');
}