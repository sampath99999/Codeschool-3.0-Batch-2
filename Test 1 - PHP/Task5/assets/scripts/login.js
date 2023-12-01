function register() {
    window.location.replace("http://localhost/CodeSchool/Task5/register.html");
}

$("#login_form").submit(function (event) {
    event.preventDefault();
    console.log("Form submitted"); 
    if (validateSi()) {
        emailId = $("#l_email").val();
        password = $("#l_password").val();
        aj(emailId,password);
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
        url: "./login.php",
        data: form,
        dataType: "JSON",
        success: function (response) {
            console.log(response)
            if (response.status) {
                alert(data.message, " ", "success");
                window.location.replace("./home.html");
            } else {
                alert(data.message, " ", "error");
            }
        },
        
    });
}