function salary(event) {



    // Get form data
    var employee_code = $("#employee_code").val();
    var earning_type = $("#earning_type").val();
    var amount = $("#earning_amount").val();
    var earning_date = $("#earning_date").val();
    var deduction_type = $("#deduction_type").val();
    var damount = $("#deduction_amount").val();
    var deduction_date = $("#deduction_date").val();

    // Your server-side endpoint URL
    var url = "../Api/AddingSalary.php"; // Replace with your actual URL

    // Make the Ajax call
    $.ajax({
        type: "POST",
        url: url,
        data: {
            employee_code: employee_code,
            earning_type: earning_type,
            amount: amount,
            earning_date: earning_date,
            deduction_type: deduction_type,
            damount: damount,
            deduction_date: deduction_date
        },
        datatype: "JSON",
        success: function(response) {
            response = JSON.parse(response);
            console.log(response);

            // Handle the response from the server as needed
            if (response.status) {
                // The submission was successful
                alert("Salary details submitted successfully!");
                // Optionally, you can close the modal or redirect the user
                $("#salaryModal").modal("hide");
            } else {
                // The server returned an error
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