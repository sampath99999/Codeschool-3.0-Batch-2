let userInfo;
userInfo = localStorage.getItem('users');
user = JSON.parse(userInfo);

$('#greeting').text(`${users.username.replace(/\b\w/g, l => l.toUpperCase())}!`);

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

  for (let i = 0; i < product.length; i++) {
    final_price += product[i].total_price
    $('#showOrder').append(`
      <tr>
      <td align="center" style="vertical-align:middle;">${product[i].order_no}</td>
      <td align="center" style="vertical-align:middle;">
        <img src="${product[i].image}" alt="" height="100px" />
      </td>
      <td align="center" style="vertical-align:middle;">${product[i].name}</td>
      <td align="center" style="vertical-align:middle;">&#8377; ${product[i].price}</td>
      <td align="center" style="vertical-align:middle;">${product[i].quantity}</td>
      <td align="center" style="vertical-align:middle;">&#8377; ${product[i].discount}</td>
      <td id="final" align="center" style="vertical-align:middle;">&#8377; ${product[i].total_price}</td>
      </tr>
      `)
  };
  $('.display-5').html(`Order Value: &#8377;${final_price}`);
}

function signout() {
  localStorage.removeItem('user');
  localStorage.removeItem('token');
  alert("Logged Out Successfully!");
  window.location.replace('http://localhost/Task4/index.html');
}