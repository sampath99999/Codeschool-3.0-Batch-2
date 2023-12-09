if (!localStorage.getItem("token")) {
    location.href = "./../dashboard.html";
}

$.ajax({
    url: "http://localhost/PHP_Task/api/getUser.php",
    type: "POST",
    data: {
        token: localStorage.getItem("token"),
    },
    success: (response) => {
       

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

function logout() {
    localStorage.removeItem("token");
    location.href = "./../login.html";
}
$(document).ready(function(){
    $("#button1").click(function(){
        location.href="./dashboard.html";
    })
})

$(document).ready(function () {
    $.ajax({
        url:  "http://localhost/PHP_Task/api/dashboard.php",
        method: 'GET',
        dataType: 'json',
        success: function (response) {
            if (response.status) {
                var products = response.data;

                if (products.length > 0) {
                    var html = '<div class="row flex-wrap ">';
                    $.each(products, function (index, product) {
                        html += '<div class="col-md-3">';
                        html += '<div class="card mb-4 shadow-sm" >';
                        html += '<img src="' + product.url + '" class=" card1 card-img-top img-fluid" alt="..." data-bs-toggle="modal" data-bs-target="#productModal" data-title="' + product.title + '" data-description="' + product.description + '" data-price="' + product.price + '" data-status="' + product.status + '">';
                        html += '<div class="card-body d-none">'; 
                        html += '<p class="card-text"><strong>Title:</strong> ' + product.title + '</p>';
                        html += '<p class="card-text"><strong>Description:</strong> ' + product.description + '</p>';
                        html += '<p class="card-text"><strong>Price:</strong> ' + product.price + '</p>';
                        html += '<p class="card-text"><strong>Mode:</strong> ' + product.status + '</p>';
                        html += '<button type="button" class="btn btn-primary" onclick="deleteFromCart()">Delete</button>';
                        html += '</div></div></div>';
                    });
                    html += '</div>';
                    $('#productContainer').html(html);
                } else {
                    $('#productContainer').html('No products found.');
                }
            } else {
                console.error(response.message);
            }
        },
        error: function (xhr, status, error) {
            console.error(error);
        }
    })
});


$('#productModal').on('show.bs.modal', function (event) {
    var img = $(event.relatedTarget); 
    var title = img.data('title');
    var description = img.data('description');
    var price = img.data('price');
    var seller1=img.data('seller1');
  
    $.ajax({
        url: "http://localhost/PHP_Task/api/seller.php",
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log(data)
            
            if (data.length > 0) {
                var user = data[2]; 
                var user_name = user.user_name;
                var phone_number = user.phone_number;

                var modal = $('#productModal');
                modal.find('.modal-body').html(
                    '<img src="' + img.attr('src') + '" class="card-img-top img-fluid"  alt="...">' +
                    '<p class="card-text"><strong>Title:</strong> ' + title + '</p>' +
                    '<p class="card-text"><strong>Description:</strong> ' + description + '</p>' +
                    '<p class="card-text"><strong>Price:</strong> ' + price + '</p>' +
                    '<p class="card-text"><strong>User Name:</strong> ' + user_name + '</p>' +
                    '<p class="card-text"><strong>Phone Number:</strong> ' + phone_number + '</p>'
                );
            }
        },
        error: function(error) {
            // Handle errors
            console.error(error);
        }
    });
});

function fetchproducts(searchTerm = null) {
    $.ajax({
        url: 'http://localhost/PHP_Task/api/dashboard.php',
        type: 'GET',
        data: { search: searchTerm },
        dataType: 'html',
        success: function(response) {
            $('#product-listing').html(response);
        },
        error: function(error) {
            console.error('Error:', error);
        }
    });
}


$(document).ready(function() {
    
    fetchproducts();

    
    $('#fetch-all').click(function() {
        fetchproducts();
    });

   
    $('#search').click(function() {
        var searchTerm = $('#search-term').val();
        fetchproducts(searchTerm);
    });
});
 

