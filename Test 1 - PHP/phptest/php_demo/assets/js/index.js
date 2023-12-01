$(document).ready(function () {
    loadDonationData();

    // Step 1: User Details
    $("#userForm").submit(function (event) {
        event.preventDefault();
        console.log(getUserFormData());
        ajaxCall(getUserFormData());
    });

    // Step 2: Amount
    $("#amountForm").submit(function (event) {
        event.preventDefault();
        console.log(getAmountFormData());
        ajaxCall(getAmountFormData());
    });

    // Step 3: Card Details
    $("#cardDetailsForm").submit(function (event) {
        event.preventDefault();
        console.log(getCardDetailsFormData());
        ajaxCall(getCardDetailsFormData());
    });
});

function getUserFormData() {
    return {
        name: $("input[name='name']").val(),
        email: $("input[name='email']").val(),
        phone: $("input[name='phone']").val(),
        amount: $("input[name='customAmount']").val(),
        cardNumber: $("input[name='cardNumber']").val(),
        expiryDate: $("input[name='expiryDate']").val(),
        cvv: $("input[name='cvv']").val(),
    };
}

// function getAmountFormData() {
//      return {
//         amount: $("input[name='customAmount']").val(),
//     };
// }

// function getCardDetailsFormData() {
//     return {
//         cardNumber: $("input[name='cardNumber']").val(),
//         expiryDate: $("input[name='expiryDate']").val(),
//         cvv: $("input[name='cvv']").val(),
//     };
// }

function ajaxCall(formData) {
    $.ajax({
        type: "POST",
        url: "http://localhost/phptest/php_demo/api/index.php",
        data: formData,
        success: function (response) {
            console.log(response);
            console.log("Donation added successfully");
            loadDonationData();
        },
        error: function (error) {
            console.error("Error:", error);
            // Handle error scenarios
        },
    });
}

function loadDonationData() {
    // Implement the logic to load donation data on your webpage
    console.log("Loading Donation Data...");
}
