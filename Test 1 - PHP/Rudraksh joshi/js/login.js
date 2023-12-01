"use strict";

console.log("hi");

if (localStorage.getItem("token")) {
  const token = localStorage.getItem("token");

  checkUserOrAdmin(token);
}
$("#form_login").submit(function (e) {
  e.preventDefault();
  const email = $("#email_login").val();
  const password = $("#password_login").val();

  if (
    validate(email, /^\w{3,}@\w{3,}\.\w{2,}$/) &&
    validate(
      password,
      /^(?=.*[A-Z])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?/~\\-])(?=.*[0-9]).{6,}$/
    )
  ) {
    checkDetailsInDb(email, password);
  } else {
    alert("someting went wrong");
  }

  function validate(string, regex) {
    if (regex.test(string)) {
      return true;
    } else {
      return false;
    }
  }

  function checkDetailsInDb() {
    $.ajax({
      url: "../php/login.php",
      type: "POST",
      dataType: "JSON",
      data: { email, password },
      success: function (response) {
        console.log(response.message);
        if (response.status) {
          localStorage.setItem("token", response.data);
          if (response.message == "admin") {
            console.log("admin");
            window.location.href = "./dashboard.html";
          }
          if (response.message == "user") {
            console.log("user");
            window.location.href = "./homepage.html";
          }
        } else {
          alert("incorrect email or password");
        }
      },
      error: function (error) {
        console.log(error);
      },
    });
  }
});

function checkUserOrAdmin(token) {
  $.ajax({
    url: "../php/check_user_or_admin.php",
    headers: { token },
    dataType: "JSON",
    success: function (response) {
      console.log(response);
      console.log(response.message);
      if (response.message == "admin") {
        console.log("admin");
        swal.fire(
          "Admin was already logged in",
          "redirecting to Dashboard..",
          "warning"
        );
        setTimeout(() => {
          window.location.replace("../html/dashboard.html");
        }, 2000);
      } else {
        console.log("user");
        swal.fire(
          "User was already logged in",
          "redirecting to homepage..",
          "warning"
        );
        setTimeout(() => {
          window.location.replace("../html/homepage.html");
        }, 2000);
      }
    },
    error: function (error) {
      console.log(error);
    },
  });
}
