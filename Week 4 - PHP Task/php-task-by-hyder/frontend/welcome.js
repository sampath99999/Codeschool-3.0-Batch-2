$(document).ready(function () {
    // employee-btn-onclick
    
    
        var username = localStorage.getItem("username");
        $("#username").text(username);

        
        var isTableVisible = false;

    $(".btn-employees").on("click", function () {
        buttonClick();
    });

    function buttonClick() {
        isTableVisible = !isTableVisible; 
        toggleTableVisibility();
        getEmployees(); 
    }

    function toggleTableVisibility() {
        const table = $("#employees_details_table");
        if (isTableVisible) {
            table.removeClass('visually-hidden');
        } else {
            table.addClass('visually-hidden');
        }
    }

    function getEmployees() {
        $.ajax({
            url: "http://localhost/code_school/php-task-by-hyder/backend/getemployees.php",
            method: "GET",
            data: { username: username },
            success: function (results) {
                console.log(results);
                var userDetails = results.data.userDetails;
                $('#employees_table_store').empty();
                userDetails.forEach(function (employee) {
                    $('#employees_table_store').append(
                        $('<tr>').append(
                            $('<td>').text(employee.employee_code),
                            $('<td>').text(employee.name),
                            $('<td>').text(employee.doj),
                            $('<td>').text(employee.dob),
                            $('<td>').text(employee.gender),
                            $('<td>').text(employee.phone),
                            $('<td>').text(employee.status),
                            $('<td>').text(employee.designation),
                            $('<td>').text(employee.city_name),
                        )
                    );
                });
            },

            error: function (error) {
                console.error("Error fetching data:", error);
            },
            complete: function () {
                // No need to disable a button since there's no button mentioned in this code snippet
            },
        });
    }
//--------------------------------------Adding new employee details---------------------------------------------------------------------   
            
            $("#employeeDetails").submit(function (event) {
                event.preventDefault();
                sendData();
            });
        
            function sendData() {
                var new_employee_data = {
                    employee_code: $("input[name='employee_code']").val(),
                    first_name: $("input[name='first_name']").val(),
                    last_name: $("input[name='last_name']").val(),
                    doj: $("input[name='doj']").val(),
                    dob: $("input[name='dob']").val(),
                    gender: $("input[name='gender']").val(),
                    phone: $("input[name='phone']").val(),
                    w_id: $("input[name='w_id']").val(),
                    d_id: $("input[name='d_id']").val(),
                    l_id: $("input[name='l_id']").val(),
                    ddo_code: $("input[name='ddo_code']").val()
                };
        
                console.log("Form Data:", new_employee_data);
        
                $.ajax({
                    type: "POST",
                    url: "http://localhost/code_school/php-task-by-hyder/backend/addemployee.php",
                    data: new_employee_data,
                    success: function (response) {
                        console.log("Server Response:", response);
                        console.log(response.status);
        
                        if (response.status === true) {
                            // Display success message using Swal.fire
                            Swal.fire({
                                icon: 'success',
                                title: "Employee added successfully",
                                text: "OK"
                            });
        
                            // Clear the form after successful submission
                            $("#employeeDetails")[0].reset();
                        } else {
                            
                            Swal.fire({
                                icon: 'error',
                                title: "Error",
                                text: response.message
                            });
                        }
                    },
                    error: function (error) {
                        console.error("Error:", error);
                        $("#responseMessage").text("Error communicating with the server.").css("font-size", "16px");
                    },
                });
            }
 //--------------------------------------Adding salary details---------------------------------------------------------------------------   
           
        $("#salaryDetails").submit(function (event) {
            event.preventDefault();
            sendSalaryData();
        });
    
        function sendSalaryData() {
            var new_salary_data = {
                employee_code: $("input[name='employee_code1']").val(),
                earn_deduction_id: $("input[name='earn_deduction_id']").val(),
                amount: $("input[name='amount']").val(),
                with_effect_date: $("input[name='with_effect_date']").val(),
            };
    
            console.log("Salary Form Data:", new_salary_data);
    
            $.ajax({
                type: "POST",
                url: "http://localhost/code_school/php-task-by-hyder/backend/addsalarydata.php",
                data: new_salary_data,
                success: function (response) {
                    console.log("Server Response:", response);
                    console.log(response.status);
    
                    if (response.status === true) {
                        // Display success message using Sweet alert
                        Swal.fire({
                            icon: 'success',
                            title: "Salary added successfully",
                            text: "OK"
                        });
    
                        // Clear the form after successful submission
                        $("#salaryDetails")[0].reset();
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: "Error",
                            text: response.message
                        });
                    }
                },
                error: function (error) {
                    console.error("Error:", error);
                    $("#responseMessage").text("Error communicating with the server.").css("font-size", "16px");
                },
            });
        }
//-------------------------------------------------Get salary details----------------------------------------------------------------
    
    
    
    $("#fetchSalary").submit(function (event) {
        $("#fetchedSalaryContainer").removeClass("visually-hidden");
        event.preventDefault();
        
        getSalaryData();
    });
    
    function getSalaryData() {
        var fetch_salary_data = {
            employee_code: $("input[name='employee_code_fetchSalary']").val(),
            ddo_code: $("input[name='ddo_code_fetchSalary']").val(),
            month: $("input[name='month_fetchSalary']").val(),
            year: $("input[name='year_fetchSalary']").val(),
        };
    
        console.log("getSalary Form Data:", fetch_salary_data);
    
        $.ajax({
            type: "GET",
            url: "http://localhost/code_school/php-task-by-hyder/backend/getSalaryDetails.php",
            data: fetch_salary_data,
            success: function (results) {
                console.log(results);
    
                if (results.status) {
                    const salaryDetails = results.data;
    
                    
                    $("#emp_code").text(salaryDetails.employee_code);
                    $("#emp_Name").text(salaryDetails.employee_name);
    
                    // Update earnings
                    $("#emp_bp").text(salaryDetails.basic_pay);
                    $("#emp_da").text(salaryDetails.da);
                    $("#emp_hra").text(salaryDetails.hra);
                    $("#emp_cca").text(salaryDetails.cca);
    
                    // Update deductions
                    $("#emp_insurance").text(salaryDetails.insurance);
                    $("#emp_pt").text(salaryDetails.pt);
                    $("#emp_pf").text(salaryDetails.pf);
    
                    // Update total
                    $("#emp_gross").text(salaryDetails.gross);
                    $("#emp_deduction").text(salaryDetails.deduction);
                    $("#emp_net").text(salaryDetails.net);
                } else {
                    console.error(results.message);
                }
            },
    
            error: function (error) {
                console.error("Error:", error);
                $("#responseMessage").text("Error communicating with the server.").css("font-size", "16px");
            },
        });
    }
    
    
    $("#closeSalaryDetails").on("click", function() {
        $("#fetchedSalaryContainer").addClass("visually-hidden");
    });
    
});  
    //---------------------------------Logout function----------------------------------------------------------------------
       
        
    
function logOut() {
    localStorage.removeItem("username");
    $.ajax({
        url: "logout.php",
        method: "GET",
        success: function () {
            // On successful logout, redirect to the login page
            location.href = "login.html";

            // Add a new state to the browser history to prevent going back
            history.pushState(null, null, null);
        },
        error: function (error) {
            console.error("Error logging out:", error);
            // Still redirect to the login page even if there's an error
            location.href = "login.html";
        }
    });
}
    