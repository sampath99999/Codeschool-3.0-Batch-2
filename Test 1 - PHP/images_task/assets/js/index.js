let category = [];
let product = [];
let myCart = [];

function signin() {
  window.location.replace("http://localhost/images_task/assets/signin.html");
}

user = localStorage.getItem('user');
userInfo = JSON.parse(user);


if (localStorage.getItem('token')) {
  window.location.replace("http://localhost/images_task/assets/loggedindex.html");
}

$.ajax({
  url: "./api/image.php",
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
    url: "./api/imageFilter.php",
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