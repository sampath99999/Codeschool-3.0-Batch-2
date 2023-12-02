let category = [];
let product = [];
let myCart = [];

let userInfo;
userInfo = localStorage.getItem('user');
user = JSON.parse(userInfo);

myCart = JSON.parse(localStorage.getItem('my_cart'));

if (!myCart) {
  myCart = [];
}

if (user.user_type_id == 2) {

  cartCount();
  setGetCart();
}

if (!userInfo) {
  alert("Please Sign In, Redirecting You...");
  window.location.replace("http://localhost/ecommerce/assets/signin.html");

} else if (user.user_type_id == 1) {
  alert("Please Sign In using a Customer Account, Redirecting You...");
  window.location.replace("http://localhost/ecommerce/assets/signin.html");
}

$('#greeting').text(`${user.name.replace(/\b\w/g, l => l.toUpperCase())}!`);

function signin() {
  window.location.replace("http://localhost/ecommerce/assets/signin.html");
}

function signup() {
  window.location.replace("http://localhost/ecommerce/assets/signup.html");
}

function myOrder() {
  window.location.replace("http://localhost/ecommerce/assets/loggedindexorder.html");
}


$.ajax({
  url: "../api/cards.php",
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
    url: "../api/productsFilter.php",
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

function addToCart(index) {
  let product = products[index];

  product.quantity = 1;

  let status = false;

  for (let i = 0; i < myCart.length; i++) {
    if (myCart[i].id == product.id) {
      myCart[i].quantity += 1;
      status = true;
      break;
    }
  }
  if (!status) {
    myCart.push(product);
  }

  $.ajax({
    url: '../api/addProductCart.php',
    method: 'POST',
    dataType: 'json',
    data: { product: product, user_id: user.id },
    success: function (data) {
      cartCount();
    },
    error: function (status) {
      console.log('Request failed with status: ' + JSON.stringify(status));
    }
  });
  let q = 0
  for (let i = 0; i < myCart.length; i++) {
    q += myCart[i].quantity
    $('#cartValue').text(`Cart: ${q}`);
  }
}

function cartCount() {

  const formData = {
    user_id: user.id,

  }
  $.ajax({
    url: '../api/countCart.php',
    method: 'POST',
    dataType: 'json',
    data: formData,
    success: function (data) {
      console.log(data)  
      let myCartCount = data.data;
      $("#cartValue").text(`Cart: ${myCartCount[0].count}`);

    },
    error: function (status) {
      console.log('Request failed with status: ' + JSON.stringify(status));
    }
  });

}

function setGetCart() {

  const formData = {
    user_id: user.id,
    products: JSON.parse(localStorage.getItem('my_cart'))
  }


  $.ajax({
    url: '../api/setGetCart.php',
    method: 'POST',
    dataType: 'json',
    data: formData,
    success: function (data) {
      if (data.status) {
        myCart = data.data;
        showCart(myCart);
      }

    },
    error: function (status) {
      console.log('Request failed with status: ' + JSON.stringify(status));
    }
  });
}

function showCart() {

  $("#showMyCart").empty();
  if (myCart.length == 0) {

    $(".shownoproducts").text("Add some Products to get started!");
  } else {
    let q = 0
    for (let i = 0; i < myCart.length; i++) {

      q += myCart[i].quantity
      $('#cartValue').text(`Cart: ${q}`);


      $("#showMyCart").append(`<tr>
             <td align="center" style="vertical-align:middle;">
               <img src="${myCart[i].image}" alt="" height="100px" />
             </td>
             <td align="center" style="vertical-align:middle;">${myCart[i].name}</td>
             <td align="center" style="vertical-align:middle;">${myCart[i].quantity}</td>
           </tr>`)

    };

  }

}

function orderNow() {

  if (myCart.length == 0) {
    alert("Add some Products to get started!")
  }


  $.ajax({
    url: '../api/orderProduct.php',
    method: 'POST',
    dataType: 'json',
    data: { product: myCart, user_id: user.id },
    success: function (data) {

      if (data.status) {
        cartCount();
        alert(data.message);
        $('#closebutton').click();
      }
    },
    error: function (status) {
      console.log('Request failed with status: ' + status);
    }
  });

}

function signout() {
  localStorage.removeItem('user');
  localStorage.removeItem('token');
  alert("Logged Out Successfully!");
  window.location.replace('http://localhost/ecommerce/index.html');
}