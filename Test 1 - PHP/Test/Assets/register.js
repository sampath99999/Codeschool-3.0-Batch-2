function register() {
    var username = $("#username").val();
    var password = $("#password").val();
    var name = $("#name").val();
    var email = $("#email").val();
    var number = $("#number").val();

    console.log(username);
    console.log(password);
    console.log(name);
    console.log(email);
    console.log(number);

    var url = "../Api/users.php";

    // Make the Ajax call with dataType set to "json"
    $.ajax({
        type: "POST",
        url: url,
        data: {
            username: username,
            password: password,
            name: name,
            email: email,
            number: number
        },
        dataType: "json", // Specify the expected data type
        success: function(response) {
            if (response.status) {


                Swal.fire({
                    icon: 'success',
                    title: 'register successful!',
                    showConfirmButton: false

                });
                location.href = "./login.html";
            } else {
                // Handle the case when login fails
                Swal.fire({
                    icon: 'error',
                    title: 'Register failed',
                    text: 'Invalid input'
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