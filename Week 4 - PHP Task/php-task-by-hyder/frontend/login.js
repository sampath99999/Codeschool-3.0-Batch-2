$(document).ready(function () {
    history.pushState(null, null, location.href);
    window.addEventListener('popstate', function (event) {
      history.pushState(null, null, location.href);
      // Check if the user is logged in, and if not, redirect to login.html
      if (!isLoggedIn()) {
        location.href = "login.html";
      }
    });
    $("#loginForm").submit(function (event) {
        event.preventDefault();
        login();
    });

    function login() {
        var formData = {
            username: $("input[name='username']").val(),
            password: $("input[name='password']").val()
        };

        console.log("Form Data:", formData);
        
        $.ajax({
            type: "POST",
            url: "http://localhost/code_school/php-task-by-hyder/backend/login.php",
            data: formData,
            dataType: "json", 
            success: function (response) {
                console.log(response);
                if(response.status == true){
                    
                    localStorage.setItem("username", formData.username);
                    alert("login successful");
                    location.href = "welcome.html";

                }
                swal.fire({
                    icon: 'error',
                    title: "Error",
                    text: response.message
                });
            },
            error: function (error) {
                console.error("Error:", error);
                // Add error handling logic here
                swal.fire({
                    icon: 'error',
                    title: "Error",
                    text: "An error occurred during the login process."
                });
            }
        });
    }
});