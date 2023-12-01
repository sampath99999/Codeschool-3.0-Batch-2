let category = [];
let cart = [];

function login() {
  window.location.replace("http://localhost/CodeSchool/Task4/login.html");
}

function register() {
  window.location.replace("http://localhost/CodeSchool/Task4/register.html");
}

$.ajax({
  url: "api/cards.php",
  method: 'GET',
  dataType: 'json',
  success: function (response) {
    
    category = response.data.category
    product = response.data.product

    addACategory(category)
    addAProduct(product)

  },
  error: function (status) {
    console.log('Request failed with status: ' + status);
  }
});

function addACategory(category) {
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

function addAProduct(product) {
  $('#productData').empty();
  for (let i = 0; i < product.length; i++) {
    $('#productData').append(`
        <div class="col-3">
          <div class="ms-3">
          <div class="card border-2 shadow-lg justify-content-center overflow-hidden" style="width: 20rem; height: 25rem">
              <img src="${product[i].image}" class="card-img-top mt-5 h-50" alt="Broken Link" style="object-fit: contain"/>
              <div class="card-body d-flex flex-column align-items-center">
                <h5 class="card-title fw-bolder text-center">${product[i].name}</h5>
                <p class="card-text">
                  <span>${product[i].price}</span>
                </p>
                <a href="#" class="btn btn-secondary" onclick="addToCart(${i})">Add to Cart</a>
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
    url: "api/filterProducts.php",
    method: 'POST',
    dataType: 'json',
    data: selection,
    success: function (response) {
      products = response.data
      addAProduct(response.data)
    },
    error: function (status) {
      console.log('Error Occurred: ' + status);
    }
  });
}

function addToCart(index) {
  
  cart.push(product[index]);

  
  alert("Product added to the cart!");
}

function isLoggedIn() {
  
  return false;
}


function showMyCart() {
  $('#showMyCart').empty();
  for (let i = 0; i < cart.length; i++) {
      $('#showMyCart').append(`
          <tr>
              <th scope="row">${i + 1}</th>
              <td><img src="${cart[i].image}" alt="Product Image" style="width: 50px; height: 50px;"></td>
              <td>${cart[i].name}</td>
              <td>1</td> <!-- You might want to implement quantity functionality -->
          </tr>
      `);
  }
}

$('#exampleModal').on('show.bs.modal', function (event) {
  showMyCart();
});

function orderNow(){
  $.ajax({
    url: "api/orderProduct.php",
    method: 'POST',
    dataType: 'json',
    data: selection,
    success: function (response) {
      products = response.data
      addAProduct(response.data)
      alert(response.message)
    },
    error: function (status) {
      console.log('Error Occurred: ' + status);
    }
  });
}
