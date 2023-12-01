"use strict";
$(document).ready(function() {
    // if there is token already present then redirect to products page
    // if (localStorage.getItem("token")) {
    //   Swal.fire({
    //     title: "Redirecting to Products page....",
    //     text: "You are already logged in.....",
    //     icon: "info",
    //     confirmButtonText: "wait a sec.....",
    //   });
    //   setTimeout(() => {
    //     window.location.href = "../products/products.html";
    //   }, 2000);
    // }

    clearErrors();

    // console.log(window.location.href);
    $("form").submit(function(event) {
        event.preventDefault();
        const fullname = $(".fullname").val();
        const phone = $(".phone").val();
        const email = $(".email").val();
        const username = $(".username").val();
        const password = $(".password").val();

        console.log(fullname, phone, email, username, password);
        //validate
        const is_valid = validate(fullname, phone, email, username, password);

        if (is_valid) {
            clearErrors();

            const formObject = {
                fullname,
                phone,
                email,
                username,
                password,
            };

            console.log("hiiii");
            $.ajax({
                url: "./api/register.php",
                type: "POST",
                data: formObject,
                success: function(response) {
                    // console.log("success...✅");
                    console.log(formObject);
                    console.log(response);
                    // const responseObject = JSON.parse(response);
                    console.log(responseObject);

                    if (responseObject.status == true) {
                        Swal.fire({
                            title: "Sucess!",
                            text: "Your details have been Submitted",
                            icon: "success",
                        });
                        setTimeout(() => {
                            window.location.href = "login.html";
                            console.log(window.location.href);
                        }, 3000);
                        // redirect to login page
                    } else {
                        const error = responseObject.data.errorInfo;
                        /* for testing
          // const error2 = responseObject.data.errorInfo[2]['DETAIL'];
          // const error3 = responseObject.data.errorInfo[1];
          // const error4 = responseObject.data.errorInfo[0];
          // const error5 = responseObject.data.errorInfo[0];
          // console.log(error);
          // console.log(error2);
          // console.log(error3);
          // console.log(error4  ); */
                        Swal.fire({
                            title: "Error!",
                            text: error,
                            icon: "error",
                        });
                    }
                },
                error: function(error) {
                    console.error("fail....❌");
                    console.log(error);
                },
            });
        }
    });
});

// validation fucntion

function validate(fullname, phone, email, username, password) {
    const fullName_regex = /^[a-zA-z\s?]{5,}$/;
    const phone_regex = /^\d{10}$/;
    const email_regex = /^\w{3,}@\w{3,}\.\w{2,}$/;
    const username_regex = /[a-zA-Z]{3,}\d{0,3}$/;
    const password_regex =
        /^(?=.*[A-Z])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?/~\\-])(?=.*[0-9]).{6,}$/;

    if (!fullName_regex.test(fullname)) {
        displayErrors("fullNameError");
        return false;
    } else {
        $(".fullname").addClass("is-valid");
    }
    if (!phone_regex.test(phone)) {
        displayErrors("phoneError");
        return false;
    } else {
        $(".phone").addClass("is-valid");
    }
    if (!email_regex.test(email)) {
        displayErrors("emailError");
        return false;
    } else {
        $(".email").addClass("is-valid");
    }
    if (!username_regex.test(username)) {
        displayErrors("usernameError");
        return false;
    } else {
        $(".username").addClass("is-valid");
    }
    if (!password_regex.test(password)) {
        displayErrors("passwordError");
        return false;
    } else {
        $(".password").addClass("is-valid");
    }

    return true;
}

function displayErrors(error_name) {
    if (error_name === "fullNameError") {
        $(".FullName-instruction").show();
        $(".fullname").addClass("is-invalid");
    }
    if (error_name === "phoneError") {
        $(".Phone-instruction").show();
        $(".phone").addClass("is-invalid");
    }
    if (error_name === "emailError") {
        $(".Email-instruction").show();
        $(".email").addClass("is-invalid");
    }
    if (error_name === "usernameError") {
        $(".Username-instruction").show();
        $(".username").addClass("is-invalid");
    }
    if (error_name === "passwordError") {
        $(".Password-instruction").show();
        $(".password").addClass("is-invalid");
    }
}

function clearErrors() {
    $(".FullName-instruction").hide();
    $(".fullname").removeClass("is-invalid");
    $(".Phone-instruction").hide();
    $(".phone").removeClass("is-invalid");
    $(".Email-instruction").hide();
    $(".email").removeClass("is-invalid");
    $(".Username-instruction").hide();
    $(".username").removeClass("is-invalid");
    $(".Password-instruction").hide();
    $(".password").removeClass("is-invalid");
}