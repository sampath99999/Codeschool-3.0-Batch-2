function login() {
    window.location.replace("http://localhost/CodeSchool/Task5/login.html");
  }
  
  function register() {
    window.location.replace("http://localhost/CodeSchool/Task5/register.html");
  }

  
  let postImage = "";
$("#addPlot").click(function(){
    const name = $("#name").val();
    const description = $("#description").val();
    const image = $("#image").val();
    console.log(name,description,postImage);
})


$("#image").change(function () {
    const reader = new FileReader();
    reader.readAsDataURL($("#image").prop("files")["0"]);
    reader.addEventListener("load", function () {
      postImage = reader.result;
    });
  });

  
  function addNewImage() {
    let name = $("#name").val();
    let description = $("#description").val();
    let image = $("#image").val();
  
  
    let form = {
      name: name,
      description: description,
      image: postImage
    }
  
    $.ajax({
      url: './addplot.php',
      method: 'POST',
      dataType: 'json',
      data: form,
      success: function (response) {
        alert(response.message, " ", "success");
        window.location.replace("http://localhost/CodeSchool/Task5/home.html");
      },
      error: function (status) {
        console.log('Request failed with status: ' + JSON.stringify(status));
      }
    });
  }

  $.ajax({
    url: "./image.php",
    method: 'GET',
    dataType: 'json',
    success: function (response) {
      console.log(response);
      plots = response.data
  
      showImages(plots)
  
    },
    error: function (status) {
      console.log('Request failed with status: ' + JSON.stringify(status));
    }
  });
  
  function showImages(plots) {
    $('#imageData').empty();
    for (let i = 0; i < plots.length; i++) {
      $('#imageData').append(`
            <div class="d-flex flex-column col-2 justify-content-center overflow-hidden">
              <div>
              <img src="${plots[i].image}" class="mt-5" alt="broken" style="width: 300px;height: 150px; object-fit: contain; ">
              </div>
              <div class="fs-3 text-black">
                ${plots[i].name}
              </div>
              <div>
                ${plots[i].description}
              </div>
            </div>
        `)
    };
  }