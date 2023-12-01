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
// for the sidebar toggle button
document.getElementById('sidebarToggle').addEventListener('click', function () {
    document.getElementById('sidebarMenu').classList.toggle('collapsed');
  });
    $(".employee").click(function(event) {
        event.preventDefault();
        loadEmployeeData();
    })
  function loadEmployeeData() {
    $.ajax({
        type: "GET",
        url: "http://localhost/test/php_demo/api/employeedata.php",
        success: function (employees) {
            console.log(employees);
            $(".table_data").empty();
            var table = $("<table>").addClass("table");
            var tableHeading = $("<thead>").append(
                $("<tr>").append(
                    $("<th>").text("ID"),
                    $("<th>").text("First Name"),
                    $("<th>").text("Last Name"),
                    $("<th>").text("Job"),
                    $("<th>").text("Email"),
                    $("<th>").text("Phone"),
                    $("<th>").text("Mobile Fax"),
                    $("<th>").text("Fax")
                )
            );
            table.append(tableHeading);
            var tableBody = $("<tbody>");
            employees.forEach(function (employee) {
                var tableRow = $("<tr>").append(
                    $("<td>").text(employee.id),
                    $("<td>").text(employee.firstname),
                    $("<td>").text(employee.lastname),
                    $("<td>").text(employee.job),
                    $("<td>").text(employee.email),
                    $("<td>").text(employee.phone),
                    $("<td>").text(employee.mobilefax),
                    $("<td>").text(employee.fax)
                );
                tableBody.append(tableRow);
            });
            table.append(tableBody);
            $(".table_data").append(table);
        },
        error: function (error) {
            console.error("Error:", error);
            alert("Error communicating with the server.");
        },
    });
}
$(document).ready(function(){
  $.ajax({
    url: "http://localhost/test/php_demo/api/getCounts.php",
    type: "GET",
    dataType: "json",
    success: function(response) {
      $(".table_data").empty();
        let data=`<div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Active Users</h5>
                    <p class="card-text">Count: ${response.activeCount}</p>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Inactive Users</h5>
                    <p class="card-text">Count: ${response.inactiveCount}</p>
                </div>
            </div>
        </div>
    </div>`
    $(".table_data").append(data);
    },
    error: function(error) {
        console.error("Error:", error);
    },
});
})
$(".dashboard").click(function() {
    
    $.ajax({
        url: "http://localhost/test/php_demo/api/getCounts.php",
        type: "GET",
        dataType: "json",
        success: function(response) {
          $(".table_data").empty();
            let data=`<div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Active Users</h5>
                        <p class="card-text">Count: ${response.activeCount}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Inactive Users</h5>
                        <p class="card-text">Count: ${response.inactiveCount}</p>
                    </div>
                </div>
            </div>
        </div>`
        $(".table_data").append(data);
        },
        error: function(error) {
            console.error("Error:", error);
        },
    });
});
