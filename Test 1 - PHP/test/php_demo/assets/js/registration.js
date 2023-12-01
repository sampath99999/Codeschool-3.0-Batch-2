if (!localStorage.getItem("token")) {
    location.href = "./../../login.html";
}

$.ajax({
    url: "http://localhost/test/php_demo/api/getUser.php",
    type: "POST",
    data: {
        token: localStorage.getItem("token"),
    },
    success: (response) => {
        response = JSON.parse(response);

        if (!response.status) {
            Swal.fire("Please Log In", response.message, "error");
            logout();
            return false;
        }
        let user = response.data;
        $("#userName").text(user.name);
    },
    error: () => {},
});

function logout() {
    localStorage.removeItem("token");
    location.href = "./../../login.html";

}
document.getElementById('sidebarToggle').addEventListener('click', function () {
    document.getElementById('sidebarMenu').classList.toggle('collapsed');
  });
  $(".clear").click(function(){
    location.href="./dashboard.html"
  });
$(document).ready(function() {
    $("#productForm").submit(function(event) {
        event.preventDefault();
        ajax_call()
    })
  })
  function getData() {
    const formData = {
        firstname: $("input[name='firstname']").val(),
        lastname: $("input[name='lastname']").val(),
        job: $("input[name='job']").val(),
        email: $("input[name='email']").val(),
        phone: $("input[name='phone']").val(),
        mobilefax: $("input[name='mobilefax']").val(),
        fax: $("input[name='fax']").val(),
    };
    console.log("Form Data:", formData);
    return formData;
    }
    function ajax_call(){
    $.ajax({
        type: "POST",
        url: "http://localhost/test/php_demo/api/employees.php",
        data: getData(),
        success: function(response) {
          if(response){
            Swal.fire({
              title: "Good job!",
              text: "Data added successfully",
              icon: "success"
            });
            location.href="./../../dashboard.html"
          }
          else{
            Swal.fire({
              icon: "error",
              title: "Name already exists",
              text: "Change the Name",
              footer: '<a href="#">Why do I have this issue?</a>'
            });
          }
        },
        error: function(error) {
            console.error("Error:", error);
        },
    })}
    