"use strict";

$(document).ready(function () {
  restrictAccess();

  let postImage = "";
  $("#thead").hide();
  $("#postimage").change(function () {
    const reader = new FileReader();
    reader.readAsDataURL($("#postimage").prop("files")["0"]);
    reader.addEventListener("load", function () {
      postImage = reader.result;
    });
  });
  $("#savePost").click(function () {
    const postTitle = $("#posttitle").val();

    const postContent = $("#postcontent").val();

    if (postTitle == "" || postImage == "" || postContent == "") {
      alert("enter all details pls....");
    } else {
      $("#addpostmodal").modal("hide");
      //   console.log(postImage, postContent, postTitle);

      insertPostInDb(postTitle, postImage, postContent);
    }
  });

  $("#posts").click(function () {
    $("#thead").hide();
    $("#totalpost").empty();
    $("#dashboardrow").empty();
    $("#postrow").empty();
    getPostDataFromDb();
  });

  $("#dashboard").click(function () {
    $("#thead").show();
    $("#totalpost").empty();
    // empty both dash board row and post row everytime so only one is present at a time
    $("#dashboardrow").empty();
    $("#postrow").empty();
    getUsersFromDb();
  });

  $("#logout").click(function () {
    localStorage.removeItem("token");
    window.location.replace("../html/login.html");
  });
  function insertPostInDb(postTitle, postImage, postContent) {
    $.ajax({
      url: "../php/store_post.php",
      type: "POST",
      dataType: "JSON",
      data: { postTitle, postImage, postContent },
      success: function (response) {
        if (response.status) {
          //   clear previous posts in ui
          // empty both dash board row and post row everytime so only one is present at a time
          $("#dashboardrow").empty();
          $("#postrow").empty();
          $("#thead").hide();
          getPostDataFromDb();
        }
      },
      error: function (error) {
        console.log(error);
      },
    });
  }

  function getPostDataFromDb() {
    $.ajax({
      url: "../php/get_posts.php",
      type: "GET",
      dataType: "JSON",
      success: function (response) {
        console.log(response);
        const allPosts = response.data;
        let totalPosts = 0;
        allPosts.forEach((post) => {
          const postId = post["id"];
          const postTitle = post["post_title"];
          const postContent = post["post_content"];
          const postImage = post["post_image"];
          //   console.log(postId, postTitle, postContent, postImage);
          totalPosts++;
          renderPost(postId, postTitle, postContent, postImage);
        });
        $("#totalpost").text(`Total Posts ${totalPosts} `);

        console.log(totalPosts);
      },
      error: function (error) {
        console.log(error);
      },
    });
  }

  function renderPost(id, title, content, src) {
    const html = `<div class="card" style="width: 18rem;">
    <img src="${src}" class="card-img-top"  style = "width:100%;height:200px;object:fit:cover"alt="image did not load">
    <div class="card-body">
      <h5 class="card-title">${title}</h5>
      <div id="content">${content}</div>
      <div id="id">${id}</div>
    </div>
  </div>`;
    $("#postrow").append(html);
  }

  function getUsersFromDb() {
    $.ajax({
      url: "../php/get_users.php",
      type: "GET",
      dataType: "JSON",
      success: function (response) {
        console.log(response);

        const users = response.data;
        users.forEach((user) => {
          renderUser(user.id, user.user_name, user.email);
          // console.log(user.id,user.user_name,user.email);
        });
      },
      error: function (error) {
        console.log(error);
      },
    });
  }
  function renderUser(id, name, email) {
    const html = ` <tr>
    <td >${id}</td>
    <td>${name}</td>
    <td>${email}</td>
 </tr>`;
    $("#dashboardrow").append(html);
  }
  function restrictAccess() {
    if (!localStorage.getItem("token")) {
      swal.fire("Please log in...", "Redirecting to login page...", "warning");

      setTimeout(() => {
        window.location.replace("../html/login.html");
      }, 1000);
    }
  }
});
