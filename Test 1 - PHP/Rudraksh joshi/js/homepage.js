"use strict";

$(document).ready(function () {
  getPostDataFromDb();
  restrictAccess();

  $("#logout").click(function () {
    localStorage.removeItem("token");
    window.location.replace("../html/login.html");
  });
});

function getPostDataFromDb() {
  $.ajax({
    url: "../php/get_posts.php",
    type: "GET",
    dataType: "JSON",
    success: function (response) {
      const allPosts = response.data;
      allPosts.forEach((post) => {
        const postId = post["id"];
        const postTitle = post["post_title"];
        const postContent = post["post_content"];
        const postImage = post["post_image"];
        //   console.log(postId, postTitle, postContent, postImage);
        renderPost(postId, postTitle, postContent, postImage);
      });
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

function restrictAccess() {
  if (!localStorage.getItem("token")) {
    swal.fire("Please log in...", "Redirecting to login page...", "warning");

    setTimeout(() => {
      window.location.replace("../html/login.html");
    }, 1000);
  }
}
