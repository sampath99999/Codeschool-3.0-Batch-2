function login(event) {
    event.preventDefault();

    var username = $("#username").val();
    var password = $("#password").val();
    console.log(username);
    console.log(password);

    var url = "../Api/login.php";

    // Make the Ajax call with dataType set to "json"
    $.ajax({
        type: "POST",
        url: url,
        data: {
            username: username,
            password: password
        },
        dataType: "json", // Specify the expected data type
        success: function(response) {
            if (response.status) {
                localStorage.setItem("token", response.data.token);
                location.href = "./product.html";
                Swal.fire({
                    icon: 'success',
                    title: 'Login successful!',
                    showConfirmButton: true,

                });

            } else {
                // Handle the case when login fails
                Swal.fire({
                    icon: 'error',
                    title: 'Login failed',
                    text: 'Invalid username or password',
                });
            }
        },
        error: function() {
            // Handle the error case
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Something went wrong!',
            });
        }
    });

}