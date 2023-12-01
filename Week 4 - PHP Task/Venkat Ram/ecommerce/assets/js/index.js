let category = [];
let product = [];
let myCart = [];

user = localStorage.getItem('user');
userInfo = JSON.parse(user);

myCart = JSON.parse(localStorage.getItem('my_cart'));

if (!myCart) {
  myCart = [];
}

if (localStorage.getItem('token')) {
  window.location.replace("http://localhost/ecommerce/assets/loggedindex.html");
}


function signin() {
  window.location.replace("http://localhost/ecommerce/assets/signin.html");
}

function signup() {
  window.location.replace("http://localhost/ecommerce/assets/signup.html");
}

$.ajax({
  url: "api/cards.php",
  method: 'GET',
  dataType: 'json',
  success: function (response) {
    category = response.data.category
    products = response.data.product

    showCategories(category)
    showProducts(products)

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
            <option value="${category[i].id}"><a class="dropdown-item" style="text-transform: capitalize;">${category[i].category_name.replace(/\b\w/g, l => l.toUpperCase())}</a></option>
    `)
  }
}

function showProducts(products) {
  $('#productData').empty();
  for (let i = 0; i < products.length; i++) {
    $('#productData').append(`
        <div class="col-3">
          <div class="ms-3">
          <div class="card mt-5 px-4 border-2 shadow-lg justify-content-center overflow-hidden" style="width: 20rem; height: 25rem">
              <img src="${products[i].image}" class="card-img-top mt-5 h-50" alt="Broken Link" style="object-fit: contain"/>
              <div class="card-body d-flex flex-column align-items-center">
                <h5 class="card-title mt-1 fs-4 fw-bolder text-center">${products[i].name}</h5>
                <p class="card-text mt-1 mb-3">
                  <span class="fs-5 ps-1">&#8377; ${products[i].price}</span>
                </p>
                <a href="#" class="btn btn-secondary pb-5 add-cmr" onclick="addToCart(${i})">Add to Cart</a>
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
    url: "api/productsFilter.php",
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

function addToCart() {
  alert("Please Sign In")
  window.location.replace("http://localhost/ecommerce/assets/signin.html");
}