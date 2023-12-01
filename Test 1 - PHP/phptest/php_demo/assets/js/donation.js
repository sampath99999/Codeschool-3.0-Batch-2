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
    location.href = "./login.html";
}
// for the sidebar toggle button
document.getElementById("sidebarToggle").addEventListener("click", function () {
    document.getElementById("sidebarMenu").classList.toggle("collapsed");
});
$(".donation").click(function (event) {
    event.preventDefault();
    loadDonationData();
});
function loadDonationData() {
    $.ajax({
        type: "GET",
        url: "http://localhost/phptest/php_demo/api/getDonations.php",
        success: function (Donations) {
            console.log(Donations);
            $(".table_data").empty();
            var table = $("<table>").addClass("table");
            var tableHeading = $("<thead>").append(
                $("<tr>").append(
                    $("<th>").text("Name"),
                    $("<th>").text("Email"),
                    $("<th>").text("Phone Number"),
                    $("<th>").text("Amount"),
                    $("<th>").text("CardDetails"),
                    $("<th>").text("ExpiryDate"),
                    $("<th>").text("CVV")
                )
            );
            table.append(tableHeading);
            var tableBody = $("<tbody>");
            Donations.forEach(function (donation) {
                var tableRow = $("<tr>").append(
                    $("<td>").text(donation.name),
                    $("<td>").text(donation.email),
                    $("<td>").text(donation.phone),
                    $("<td>").text(donation.amount),
                    $("<td>").text(donation.card_number),
                    $("<td>").text(donation.expiry_date),
                    $("<td>").text(donation.cvv)
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
