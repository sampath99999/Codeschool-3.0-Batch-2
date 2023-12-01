if (!localStorage.getItem("token")) {
    location.href = "./login.html";
}

$.ajax({
    url: "http://localhost/phptest/php_demo/api/getUser.php",
    type: "POST",
    data: {
        token: localStorage.getItem("token"),
    },
    success: (response) => {
        // response = JSON.parse(response);

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
    location.href = "./dashboard.html";
}
document.getElementById("sidebarToggle").addEventListener("click", function () {
    document.getElementById("sidebarMenu").classList.toggle("collapsed");
});

function logout() {
    localStorage.removeItem("token");
    location.href = "./login.html";
}

$(document).ready(function () {
    $.ajax({
        url: "http://localhost/phptest/php_demo/api/count.php",
        type: "GET",
        dataType: "json",
        success: function (response) {
            $(".table_data").empty();
            let data = `<div class="row">
          <div class="col-md-6">
              <div class="card">
                  <div class="card-body">
                      <h5 class="card-title">Active Users</h5>
                      <p class="card-text">Count: ${response.activeCount}</p>
                  </div>
              </div>
          </div>
      </div>`;
            $(".blood_data").append(data);
        },
        error: function (error) {
            console.error("Error:", error);
        },
    });
});
