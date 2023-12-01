function render_salary(items) {
    $('.etbody tr').remove(); // Assuming you want to remove rows from the element with class 'etbody'
    $('.dtbody tr').remove();
    let salarylist = items;
    console.log(salarylist);
    var sum_of_earning = 0;
    var sum_of_deduction = 0;
    var i = 0;
    var array_size = salarylist.length;
    var j = 0;
    salarylist.forEach((ele, i) => {
        if (i % 2 == 0) {
            let earning_type = ele['earning_type'];
            let amount = ele['amount'];


            sum_of_earning += parseFloat(amount);


            const html = `<tr><td>${earning_type}</td><td>${amount}</td></tr>`;
            $('.etbody').append(html);

            i++;
        }

        if (j < (array_size / 2)) {
            let deduction_type = ele['deduction_type'];
            let damount = ele['damount'];
            sum_of_deduction += parseFloat(damount);
            const html2 = `<tr><td>${deduction_type}</td><td>${damount}</td></tr>`;
            $('.dtbody').append(html2);
            j++;
        }


    });

    const html3 = `<tr><td> Total Earning : </td><td>${sum_of_earning}</td></tr>`;
    $('.etbody').append(html3);
    const html4 = `<tr><td> Total Deduction : </td><td>${sum_of_deduction}</td></tr>`;
    $('.etbody').append(html4);
    var net = sum_of_earning - sum_of_deduction;
    const html5 = `<tr><td> Net Earning : </td><td>${net}</td></tr>`;
    $('.etbody').append(html5);


}

function salarydetail(employeecode) {
    var employeecode = employeecode;
    var url = "../Api/salarydetail.php";

    $.ajax({
        type: "POST",
        url: url,
        data: {
            employeecode: employeecode // Corrected variable assignment
        },
        dataType: "JSON", // Corrected spelling mistake
        success: function(response) {
            console.log(response);

            if (response.status) {
                render_salary(response.data);
            } else {
                alert("Error retrieving salary details. Please try again.");
            }
        },
        error: function(error) {
            console.error(error);
            alert("Error retrieving salary details. Please try again.");
        }
    });
}