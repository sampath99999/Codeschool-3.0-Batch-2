function logout() {
    localStorage.removeItem("token");
    location.href = "./../login.html";
}
$(document).ready(function () {
    function submitForm() {
        let url = $("#url").val();
        let title = $("#title").val();
        let description = $("#description").val();
        let price = $("#price").val();
        let mode = $("#mode").val();
        let seller1=$("#seller1").val();
        
        $.ajax({
            url: "http://localhost/PHP_Task/api/products.php",
            type: "POST",
            data: {
                url,
                title,
                description,
                price,
                mode,
                seller1
            },
            success: function (response) {
                console.log(response);
                try {
                    //response = JSON.parse(response);
                    if (response.status) {
                        alert("Data added successfully!");
                        let url = $("#url").val("");
                        let title = $("#title").val("");
                        let description = $("#description").val("");
                        let price = $("#price").val("");
                        let mode = $("#mode").val("");
                        let seller1 = $("#seller1").val("");
                        
                    } 
                    else {
                        alert("Failed to add data. " + response.message);
                    }
                } 
                catch (error) {
                    console.error("Error parsing JSON:", error);
                    alert("Unexpected error occurred.");
                }
            },
            error: function () {
                console.error("Error in AJAX request.");
                alert("Error in communication with the server.");
            },
        });
    }

 
    $("#button1").submit(function (event) {
        event.preventDefault(); 
        submitForm();
    });
});


function loadProductData() {
    $.ajax({
        type: "GET",
        url: "http://localhost/PHP_Task/api/dashboard.php",
        success: function (products) {
            console.log(products);
            $("#productTableBody").empty();
            products.forEach(function (product) {
                var tableRow = `<tr>
                   <td>${product.url}</td>
                    <td>${product.title}</td>
                    <td>${product.description}</td>
                    <td>${product.price}</td>
                    <td>${product.mode}</td>
                    <td>${product.seller1}</td>
                  </tr>`;
                $("#productTableBody").append(tableRow);
            });
        },
        error: function (error) {
            console.error("Error:", error);
            alert(",Error communicating with the server.");
        },
    });
}


$(document).ready(function() {
    // Event listener for user selection
    $('#seller1').on('change', function() {
        var selectedUserId = $(this).val();
        if (selectedUserId) {
            fetchSelectedUserDetails(selectedUserId);
        } else {
            // Clear the user details container if no user is selected
            $('#userDetailsContainer').html('');
        }
    });

    // Function to fetch and display selected user details
    function fetchSelectedUserDetails(userId) {
        $.ajax({
            url: 'http://localhost/PHP_Task/api/userdetails.php',
            type: 'GET',
            data: { userId: userId },
            dataType: 'json',
            success: function(data) {
                // Display user details in the container
                var userDetailsHtml = '<p><strong>User Name:</strong> ' + data.user_name + '</p>' +
                                       '<p><strong>Phone Number:</strong> ' + data.phone_number + '</p>';
                $('#userDetailsContainer').html(userDetailsHtml);
            },
            error: function(error) {
                console.error('Error fetching user details:', error);
            }
        });
    }
});