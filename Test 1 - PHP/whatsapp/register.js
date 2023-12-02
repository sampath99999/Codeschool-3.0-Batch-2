$(document).ready(function() {
    $("form").submit(function(event) {
        event.preventDefault();

        const email = $("#email").val();
        const username = $("#username").val();
        const password = $("#password").val();

        // Validate and register the user
        const is_valid = validate(email, username, password);

        if (is_valid) {
            const formObject = {
                email,
                username,
                password,
            };

            $.ajax({
                url: "./api/register.php",
                type: "POST",
                data: formObject,
                success: function(response) {
                    const responseObject = JSON.parse(response);

                    if (responseObject.status === true) {
                        // Registration successful, redirect to login page
                        window.location.href = 'login.html';
                    } else {
                        const error = responseObject.data.errorInfo;
                        Swal.fire({
                            title: "Error!",
                            text: error,
                            icon: "error",
                        });
                    }
                },
                error: function(error) {
                    console.error("Registration fail....❌");
                    console.log(error);
                },
            });
        }
    });
});