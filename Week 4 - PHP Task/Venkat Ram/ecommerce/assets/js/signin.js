function signup() {
    window.location.replace("http://localhost/ecommerce/assets/signup.html");
}

$("#si_form").submit(function (event) {
    event.preventDefault();
    if (validateSi()) {
        aj();
    }
})

let emailId;
let password;

function validateSi() {

    const regex = /[!@@#$%^^&*()_>:{<>_(*^$#@!#$^*())}]/;

    emailId = $("#si_email").val();
    $("#si_email_error").text("");
    if (!emailId) {
        $("#si_email_error").text("Please enter an e-Mail Address!");
        return;
    }
    const pattern = /[@.@@ ]/;
    if (!pattern.test(emailId)) {
        $("#si_email_error").text("Please enter a valid e-Mail Address!");
        return;
    }

    password = $("#si_pwd").val();
    $("#si_pwd_error").text("");
    if (!password) {
        $("#si_pwd_error").text("Please enter a Password!");
        return;
    }
    if (password.length < 6) {
        $("#si_pwd_error").text("Please use 6 characters or more!");
        return;
    }
    return true;
}

function aj() {
    const form = {
        emailId: emailId,
        password: password
    }
    $.ajax({
        type: "POST",
        url: "../api/signin.php",
        data: form,
        dataType: "JSON",
        success: function (response) {
            if (response.status) {
                alert(response.message, " ", "success");
                if (response.data.result[0].user_type_id == 1) {
                    window.location.replace("http://localhost/ecommerce/assets/loggedadmin.html");
                } else {
                    window.location.replace("http://localhost/ecommerce/assets/loggedindex.html");
                }
                localStorage.setItem("user", JSON.stringify(response.data.result[0]));
                localStorage.setItem("token", JSON.stringify(response.data.token));
            } else {
                alert(response.message, " ", "error");
            }
        },
        error: function (err) {
            $("#error").text(err);
        }
    });
}