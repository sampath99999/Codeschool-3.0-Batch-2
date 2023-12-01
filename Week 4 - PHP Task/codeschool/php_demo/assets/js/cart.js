function checkout() {
    $.ajax({
        url: "http://localhost/codeschool/php_demo/api/cart.php",
        type: "POST",
        success: (response) => {
            // response = JSON.parse(response);
            if (response.status) {
                displayItemsData(response.data);
            } else {
                alert("Failed to fetch items data. " + response.message);
            }
        },
        error: () => {
            alert("Error fetching items data.");
        },
    });
}

function displayItemsData(data) {
    const tableBody = $("#itemsTableBody");
    tableBody.empty(); // Clear existing data

    // Add column headers
    const headers = $("<tr>").append(
        $("<th>").text("cart_id"),
        $("<th>").text("user_id"),
        $("<th>").text("quantity"),
        $("<th>").text("total")
    );
    tableBody.append(headers);

    // Add data rows
    data.forEach((shopping_cart) => {
        const row = $("<tr>").append(
            $("<td>").text(shopping_cart.cart_id),
            $("<td>").text(shopping_cart.user_id),
            $("<td>").text(shopping_cart.quantity),
            $("<td>").text(shopping_cart.total)
        );
        tableBody.append(row);
    });
}
$(document).ready(() => {
    $(".items").click(function () {
        checkout();
    });
});
