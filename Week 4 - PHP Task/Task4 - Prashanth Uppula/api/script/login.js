function register() {
    window.location.replace("http://localhost/CodeSchool/Task4/register.html");
}

$("#login_form").submit(function (event) {
    event.preventDefault();
    console.log("Form submitted"); 
    if (validateSi()) {
        aj();
    }
});


let emailId;
let password;

function validateSi() {

    const regex = /[!@@#$%^^&*()_>:{<>_(*^$#@!#$^*())}]/;

    emailId = $("#l_email").val();
    $("#email_error").text("");
    if (!emailId) {
        $("#email_error").text("Please enter an e-Mail Address!");
        return;
    }
    const pattern = /[@.@@ ]/;
    if (!pattern.test(emailId.trim())) {
        $("#email_error").text("Please enter a valid e-Mail Address!");
        return;
    }

    password = $("#l_password").val();
    $("#password_error").text("");
    if (!password) {
        $("#password_error").text("Please enter a Password!");
        return;
    }
    if (password.length < 6 || password.length > 12) {
        $("#password_error").text("Please use 6 characters or more!");
        return;
    }
    return true;
}

function aj() {
    const form = {
        emailId: emailId,
        password: password
    };
    
    $.ajax({
        type: "POST",
        url: "./api/login.php",
        data: form,
        dataType: "JSON",
        success: function (response) {
            if (response.status) {
                alert(response.message, " ", "success");
                if (response.data.result[0].user_types_id == 1) {
                    window.location.replace("http://localhost/CodeSchool/Task4/index.html");
                } else {
                    window.location.replace("http://localhost/CodeSchool/Task4/index.html");
                }
                localStorage.setItem("user", JSON.stringify(response.data.result[0]));
                localStorage.setItem("token", JSON.stringify(response.data.token));
            } else {
                alert(response.message, " ", "error");
            }
        },
        error: function (err) {
            console.log(err);
            $("#error").text(err);
        }
    });
}