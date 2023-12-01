function render_employee(items) {
    $('.tbody tr').remove();

    let employee_list = items;
    console.log(employee_list);
    employee_list.forEach((ele) => {
        let employee_code = ele['employee_code'];
        let first_name = ele['first_name'];
        let last_name = ele['last_name'];
        let doj = ele['doj'];
        let dob = ele['dob'];
        let gender = ele['gender'];
        let phone = ele['phone'];
        let working_status = ele['working_status'];
        let designation = ele['designation'];
        let location = ele['location'];
        let ddocode = ele['ddocode'];

        const body = document.querySelector('.tbody');
        const html = `<tr><td>${employee_code}</td><td>${first_name}</td><td>${last_name}</td><td>${doj}</td><td>${dob}</td><td>${gender}</td><td>${phone}</td><td>${working_status}</td><td>${designation}</td><td>${location}</td><td>${ddocode}</td><td><a data-bs-toggle="modal" href="#" data-bs-target="#DisplaySalary"" href="#" onclick="salarydetail(${employee_code})" >Slary Detail</a></td><br></tr>`;

        $('.tbody').append(html);
    });

}

function employeelist() {
    var token = localStorage.getItem("token");
    var url = "../Api/employeelist.php";

    $.ajax({
        type: "POST",
        url: url,
        data: {
            token: token
        },
        datatype: "JSON",
        success: function(response) {
            response = JSON.parse(response);

            console.log(response);
            // Handle the response from the server as needed
            if (response.status) {

                render_employee(response.data);
            } else {

                alert("Error submitting salary details. Please try again.");
            }
        },
        error: function(error) {
            console.error(error);
            // Handle AJAX error, e.g., show an error message
            alert("Error submitting salary details. Please try again.");
        }
    });


}