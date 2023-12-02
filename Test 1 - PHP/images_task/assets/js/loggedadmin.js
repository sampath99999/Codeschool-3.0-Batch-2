let products = [];
let category = [];
let image = "";

let productName;
let userInfo;
userInfo = localStorage.getItem('user');
tokenInfo = localStorage.getItem('token');
user = JSON.parse(userInfo);
token = JSON.parse(tokenInfo);


if (!userInfo) {
  alert("Please Sign In, Redirecting You...");
  window.location.replace("http://localhost/ecommerce/assets/signin.html");
} else if (user.user_type_id != 1) {
  alert("You do not have Admin Access, Redirecting You...");
  window.location.replace("http://localhost/ecommerce/assets/loggedindex.html");
}

$('#greeting').text(`${user.name.replace(/\b\w/g, l => l.toUpperCase())}!`);

$("#addImage").click(() => {
    let iname = $("#imageName").val();
    let ilink = $("#imageLink").val();
    // console.log(iname, ilink, image)
})

$("#image").change(function () {
    const reader = new FileReader();
    reader.readAsDataURL($("#image").prop("files")["0"]);
    reader.addEventListener("load", function () {
        image = reader.result;
    });
});





function showImages(image) {
  $('#imageData').empty();
  for (let i = 0; i < image.length; i++) {
    $('#imageData').append(`
          <div class="d-flex flex-column col-2 justify-content-center overflow-hidden">
            <div>
            <img src="${image[i].image}" class="mt-5" alt="broken" style="width: 300px;height: 150px; object-fit: contain; ">
            </div>
            <div class="fs-3 text-black">
              ${image[i].image_name}
            </div>
            <div>
              ${image[i].image_link}
            </div>
          </div>
      `)
  };
}

function filterImage() {
  let selection = {
    search: $('#search').val()
  }
  // console.log(selection);

  $.ajax({
    url: "../api/imageFilter.php",
    method: 'POST',
    dataType: 'json',
    data: selection,
    success: function (response) {
      // console.log(response)
      showImages(response.data)
    },
    error: function (status) {
      console.log('Error Occurred: ' + JSON.stringify(status));
    }
  });
}

function addNewImage() {
  let iname = $("#imageName").val();
  let ilink = $("#imageLink").val();


  let form = {
    iname: iname,
    ilink: ilink,
    image: image
  }

  $.ajax({
    url: '../api/addImages.php',
    method: 'POST',
    dataType: 'json',
    data: form,
    success: function (response) {
      alert(response.message, " ", "success");
      window.location.replace("http://localhost/images_task/assets/loggedadmin.html");
    },
    error: function (status) {
      console.log('Request failed with status: ' + JSON.stringify(status));
    }
  });
}


$.ajax({
  url: "../api/image.php",
  method: 'GET',
  dataType: 'json',
  success: function (response) {
    console.log(response);
    image = response.data

    showImages(image)

  },
  error: function (status) {
    console.log('Request failed with status: ' + JSON.stringify(status));
  }
});

function signout() {
  localStorage.removeItem('user');
  localStorage.removeItem('token');
  alert("Logged Out Successfully!");
  window.location.replace('http://localhost/images_task/index.html');
}