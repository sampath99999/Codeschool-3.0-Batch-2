let userInfo;
userInfo = localStorage.getItem('user');
user = JSON.parse(userInfo);

$('#greeting').text(`${user.name.replace(/\b\w/g, l => l.toUpperCase())}!`);

let products = [];
$.ajax({
  url: '../api/myOrder.php',
  method: 'GET',
  dataType: 'json',
  success: function (data) {
    console.log(data)
    products = data.data;
    showMyOrder(data.data);
  },
  error: function (status) {
    console.log('Request failed with status: ' + JSON.stringify(status));
  }
});

function showMyOrder(products) {

  $('#showOrder').empty();
  let final_price = 0

  for (let i = 0; i < products.length; i++) {
    final_price += products[i].total_price
    $('#showOrder').append(`
      <tr>
      <td align="center" style="vertical-align:middle;">${products[i].order_no}</td>
      <td align="center" style="vertical-align:middle;">
        <img src="${products[i].image}" alt="" height="100px" />
      </td>
      <td align="center" style="vertical-align:middle;">${products[i].name}</td>
      <td align="center" style="vertical-align:middle;">&#8377; ${products[i].price}</td>
      <td align="center" style="vertical-align:middle;">${products[i].quantity}</td>
      <td align="center" style="vertical-align:middle;">&#8377; ${products[i].discount}</td>
      <td id="final" align="center" style="vertical-align:middle;">&#8377; ${products[i].total_price}</td>
      </tr>
      `)
  };
  $('.display-5').html(`Order Value: &#8377;${final_price}`);
}

function signout() {
  localStorage.removeItem('user');
  localStorage.removeItem('token');
  alert("Logged Out Successfully!");
  window.location.replace('http://localhost/ecommerce/index.html');
}