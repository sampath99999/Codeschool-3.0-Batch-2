"use strict";

$(document).ready(function () {
  $("#form_reg").submit(function (e) {
    e.preventDefault();
    const email = $("#reg_email").val();
    const password = $("#reg_password").val();
    const username = $("#reg_username").val();

    if (
      validate(email, /^\w{3,}@\w{3,}\.\w{2,}$/) &&
      validate(
        password,
        /^(?=.*[A-Z])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?/~\\-])(?=.*[0-9]).{6,}$/
      ) &&
      validate(username, /^[A-Za-z]{3,}/g)
    ) {
      postDataInDb(username, email, password);
    } else {
      console.log("invalid");
      alert("register unsuccessfull");
    }
  });

  function validate(string, regex) {
    if (regex.test(string)) {
      return true;
    } else {
      return false;
    }
  }

  function postDataInDb(username, email, password) {
    $.ajax({
      url: "../php/register.php",
      type: "POST",
      data: { username, email, password },
      dataType: "JSON",
      success: function (response) {
        if (response.status) {
          console.log(response);
          alert("registered successfully!");
          window.location.replace("../html/login.html");
        } else {
          alert("email already exists");
        }
      },
      error: function (error) {
        console.log(error);
      },
    });
  }
});
