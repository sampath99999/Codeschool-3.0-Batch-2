function signin() {
    window.location.replace("http://localhost/ecommerce/assets/signin.html");
}

$("#reg_form").submit(function (event) {
    event.preventDefault();
    if (validateReg()) {
        aj();
    }
})

let emailId;
let name;
let uname;
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

    uname = $("#reg_uname").val();
    $("#uname_error").text("");
    if (!uname) {
        $("#uname_error").text("Please enter an Username!");
        return;
    }
    if (regex.test(uname)) {
        $("#uname_error").text("Please don't use any special characters here!");
        return;
    }
    if (uname.length > 12) {
        $("#uname_error").text("Please use 12 characters or less!");
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
        uname: uname,
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
                window.location.replace("http://localhost/ecommerce/assets/signin.html");
            } else {
                alert(data.message, " ", "error");
            }
        },
        error: function (err) {
            $("#error").text(err);
        }
    });
}

