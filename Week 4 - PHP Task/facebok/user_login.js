"use strict";
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

$("#loginForm").submit(function (event) {
  // if there is token  redirect to productst

  // console.log("test");
  event.preventDefault();
  const email = $("#inputEmail").val();
  const password = $("#inputPassword").val();

  const is_valid = validate(email, password);
  if (!is_valid) {
    const warning = "Incorrect Email or Password!";
    Swal.fire({
      title: "Login Error",
      text: warning,
      icon: "error",
    });
  } else {
    const user_details = {
      email,
      password,
    };

    ajax_call(user_details);
  }
});

function validate(email, password) {
  const email_regex = /^\w{3,}@\w{3,}\.\w{2,}$/;
  const password_regex =
    /^(?=.*[A-Z])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?/~\\-])(?=.*[0-9]).{6,}$/;
  if (email_regex.test(email) && password_regex.test(password)) {
    return true;
  }

  return false;
}

function ajax_call(data) {
  $.ajax({
    url: "../api/login.php",
    type: "POST",
    data: data,
    success: function (response) {
      // console.log(response);

      const responseObject = JSON.parse(response);

      // console.log("test");
      console.log(responseObject);

      const status = responseObject.status;
      if (status === true) {
        Swal.fire({
          title: "Logged In",
          text: "You are now Logged In",
          icon: "success",
        });
        const userToken = responseObject.data.token;
        // console.log(userName, userToken);
        //setting users data in local storage
        localStorage.setItem("token", userToken);

        //redirect user to products page
        setTimeout(() => {
          console.log(window.location);
          window.location.href = "http://localhost/CodeSchool/products/";
        }, 1000);
      } else {
        Swal.fire({
          title: "Login Error",
          text: "Incorrect Email or Password!",
          icon: "error",
        });
      }
    },
    error: function (error) {
      console.log(Window);
      console.log(error);
    },
  });
}
