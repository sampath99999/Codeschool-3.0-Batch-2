if (!localStorage.getItem("token")) { location.href = "./login.html"; }

function employee(event) {



    var first_name = $("#firstName").val();
    var last_name = $("#lastName").val();
    var doj = $("#doj").val();
    var dob = $("#dob").val();
    var gender = $("#gender").val();
    var phone = $("#phone").val();
    var working_status = $("#workingStatus").val();
    var designation = $("#designation").val();
    var location = $("#location").val();
    var token = localStorage.getItem("token");

    $.ajax({
        url: "../Api/AddingEmployee.php",
        type: "POST",
        data: {
            first_name,
            last_name,
            doj,
            dob,
            gender,
            phone,
            working_status,
            designation,
            location,
            token
        },

        datatype: "JSON",

        success: (response) => {

            response = JSON.parse(response);
            if (response.status) {






            }
            l
        },
        error: (response) => {
            console.log("Error: " + response);
        },
    });
}