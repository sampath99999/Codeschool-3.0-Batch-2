function signup() {
    window.location.replace("http://localhost/images_task/assets/signin.html");
}

$("#reg_form").submit(function (event) {
    event.preventDefault();
    if (validateReg()) {
        aj();
    }
})

let emailId;
let name;
let password;

function validateReg() {

    const regex = /[!@@#$%^^&*()_>:{<>_(*^$#@!#$^*())}]/;

    emailId = $("#reg_email").val();
    $("#email_error").text("");
    if (!emailId) {
        $("#email_error").text("Please enter an e-Mail Address!");
        return;
    }
    const pattern = /[@.@@ ]/;
    if (!pattern.test(emailId)) {
        $("#email_error").text("Please enter a valid e-Mail Address!");
        return;
    }

    name = $("#reg_name").val();
    $("#name_error").text("");
    if (!name) {
        $("#name_error").text("Please enter your Name!");
        return;
    }

    password = $("#reg_pwd").val();
    $("#pwd_error").text("");
    if (!password) {
        $("#pwd_error").text("Please enter a Password!");
        return;
    }
    if (password.length < 8) {
        $("#pwd_error").text("Password: Minimum 8 Characters");
        return;
    }
    return true;
}

function aj() {
    const form = {
        emailId: emailId,
        name: name,
        password: password
    }
    $.ajax({
        url: "../api/signup.php",
        type: "POST",
        data: form,
        dataType: "JSON",
        success: function (data) {
            if (data.status) {
                alert(data.message, " ", "success");
                window.location.replace("http://localhost/images_task/assets/signin.html");
            } else {
                alert(data.message, " ", "error");
            }
        },
        error: function (err) {
            $("#error").text(err);
        }
    });
}

