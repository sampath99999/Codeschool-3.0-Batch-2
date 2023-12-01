import { redirectAlert } from "./utils.js";

export function checkData() {
  $.ajax({
    url: "../php/login.php",
    type: "POST",
    data: {
      email: $("#login-email").val(),
      password: $("#login-password").val(),
    },
    success: function (response) {
      const responseObject = JSON.parse(response);
      console.log(responseObject);
      // todo check status true or false
      // if true utils alert and redirect
      const token = responseObject.data;
      // console.log(token);
      localStorage.setItem("token", token);
      if (responseObject.status) {
        redirectAlert();
        setTimeout(() => {
          location.href = "../html/profile.html";
        }, 2000);
      } else {
        Swal.fire("Log in Failed", "Incorrect Email or Password", "error");
      }

      console.log(response);
    },
    error: function (error) {
      console.error(error);
    },
  });
}

export function postData() {
  $.ajax({
    url: "../php/sign_up.php",
    type: "POST",
    data: {
      "first-name": $("#first-name").val(),
      "last-name": $("#last-name").val(),
      "phone-number": $("#phone-number").val(),
      "date-of-birth": $("#date-of-birth").val(),
      "sign-up-email": $("#sign-up-email").val(),
      "sign-up-password": $("#sign-up-password").val(),
    },
    success: function (response) {
      const responseObject = JSON.parse(response);
      if (responseObject.status == false) {
        Swal.fire("Error", responseObject.message, "error");
        console.log($("#create-account-modal"));
        $("#create-account-modal").modal("hide");
      } else {
        Swal.fire("Signed up", "You can now log in", "success");
        $("#create-account-modal").modal("hide");
      }
    },
    error: function (error) {
      console.error(error);
      Swal.fire("Oops", error, "error");
    },
  });
}

export function store_post(token, postContent, postImageUrl) {
  $.ajax({
    url: "../php/user_post/store_post.php",
    type: "POST",
    data: { token, postContent, postImageUrl },
    dataType: "JSON", //converts response into json
    success: function (response) {
      console.log(response);

      if (response.status == true) {
        console.log("stored post ........");
      }
    },
    error: function (error) {
      console.log(error);
    },
  });
}

function getUserName(token) {
  $.ajax({
    url: "../php/get_username.php",
    type: "GET",
    headers: { token },
    dataType: "JSON", //converts response into json
    success: function (response) {
      console.log(response.data.full_name);

      if (response.status == true) {
        console.log("got user name ........");
        $("#post-username").append(response.data.full_name);
        $("#postContent").attr(
          "placeholder",
          `Whats on your mind? ${response.data.full_name}`
        );
      } else {
        window.alert("cannot get user name....log in again");
      }
    },
    error: function (error) {
      console.log(error);
    },
  });
}
getUserName(localStorage.getItem("token"));
