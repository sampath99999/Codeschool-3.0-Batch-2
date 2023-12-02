$("#loginForm").submit(function(event) {
    event.preventDefault();

    const email = $("#email").val();
    const password = $("#password").val();

    // Validate and log in the user
    ajax_call({ 'email': email, 'password': password });
});

function ajax_call(data) {
    $.ajax({
        url: "../api/login.php",
        type: "POST",
        data: data,
        success: function(response) {
            const responseObject = JSON.parse(response);
            const status = responseObject.status;

            if (status == true) {

                window.location.href = 'chat.html';
            } else {
                Swal.fire({
                    title: "Login Error",
                    text: "Incorrect Email or Password!",
                    icon: "error",
                });
            }
        },
        error: function(error) {
            console.log(error);
        },
    });
}