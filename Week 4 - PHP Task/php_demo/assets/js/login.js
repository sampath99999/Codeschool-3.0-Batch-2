if (localStorage.getItem("token")) {
    location.href = "./../../dashboard.html";
}

function login(event) {
    event.preventDefault();
    if (!validate()) {
        return false;
    }

    let email = $("#emailInput").val();
    let password = $("#passwordInput").val();

    $.ajax({
        url: "http://localhost/codeschool/php_demo/api/login.php",
        type: "POST",
        data: {
            email,
            password,
        },
        datatype: "JSON",
        success: (response) => {
            response = JSON.parse(response);
            if (!response.status) {
                Swal.fire("Login Unsuccessful", response.message, "error");
                return false;
            }
            let token = response.data.token;
            localStorage.setItem("token", token);
            location.href = "./../../dashboard.html";
        },
        error: (response) => {
            console.log("Error: " + response);
        },
    });
}

function validate() {
    clearErrors();

    let email = $("#emailInput").val();
    let password = $("#passwordInput").val();

    return true;
}

function clearErrors() {
    $("#emailInput").removeClass("is-invalid");
    $("#passwordInput").removeClass("is-invalid");

    $("#emailInputError").text("");
    $("#passwordInputError").text("");
}
