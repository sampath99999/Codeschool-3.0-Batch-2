$(document).ready(function () {
    $("#loginForm").submit(function (event) {
        event.preventDefault();
        const email = $("#emailInput").val();
        const password = $("#passwordInput").val();

        // AJAX request
        $.ajax({
            url: "./api/login.php",
            method: "POST",
            data: {
                email: email,
                password: password,
            },
            success: function (response) {
                console.log(response.status);
                localStorage.setItem("token", response.data["token"]);
                location.href = "./dashboard.html";
            },
            error: function (error) {
                // Handle error response
                console.error("Error:", error);
                // You can show an error message to the user here
            },
        });
    });
});
