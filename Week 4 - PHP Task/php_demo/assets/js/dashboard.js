if (!localStorage.getItem("token")) {
    location.href = "./../../login.html";
}

$.ajax({
    url: "http://localhost/codeschool/php_demo/api/getUser.php",
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
// for displaying theater table data;
function addTheaterData() {
    const theaterName = prompt("Enter Theater Name:");
    const location = prompt("Enter Location:");

    if (theaterName && location) {
        $.ajax({
            url: "http://localhost/codeschool/php_demo/api/addTheater.php",
            type: "POST",
            data: {
                theaterName,
                location,
            },
            success: (response) => {
                console.log(response);
                response = JSON.parse(response);
                if (response.status) {
                    alert("Theater added successfully!");
                } else {
                    alert("Failed to add theater. " + response.message);
                }
            },
            error: () => {
                alert("Error adding theater.");
            },
        });
    }
}
//deleting data from theaters

function deleteTheaterData() {
    const theaterId = prompt("Enter Theater ID to delete:");

    if (theaterId) {
        $.ajax({
            url: "http://localhost/codeschool/php_demo/api/deleteTheater.php",
            type: "POST",
            data: {
                theaterId,
            },
            success: (response) => {
                response = JSON.parse(response);
                if (response.status) {
                    alert("Theater deleted successfully!");
                } else {
                    alert("Failed to delete theater. " + response.message);
                }
            },
            error: () => {
                alert("Error deleting theater.");
            },
        });
    }
}
//adding data to shows
function addShowData() {
    const theaterId = prompt("Enter Theater ID:");
    const movieName = prompt("Enter Movie Name:");
    const showRunning = prompt("Enter Show Running Status (running/completed/other):");

    if (theaterId && movieName && showRunning) {
        // Check if a running show is being added
        if (showRunning === 'running') {
            alert("Adding a show with 'running' status");
        }

        $.ajax({
            url: "http://localhost/codeschool/php_demo/api/addShow.php",
            type: "POST",
            data: {
                theaterId,
                movieName,
                showRunning,
            },
            success: (response) => {
                console.log(response)
                if (response) {
                    alert("Show added successfully!");
                } else {
                    alert("Failed to add show. " + response.message);
                }
            },
            error: () => {
                alert("Error adding show.");
            },
        });
    }
}
// adding shows
//delete show
function deleteShowData() {
    const showId = prompt("Enter Show ID to delete:");

    if (showId) {
        // Check if the show is running before deletion
        $.ajax({
            url: "http://localhost/codeschool/php_demo/api/deleteShow.php",
            type: "POST",
            data: {
                showId,
            },
            success: (response) => {
                if (response) {
                    alert("Show deleted successfully!");
                } else {
                    alert("Failed to delete show. " + response.message);
                }
            },
            error: () => {
                alert("Error deleting show.");
            },
        });
    }
}
// getting the data
function showTheatersData() {
    $.ajax({
        url: "http://localhost/codeschool/php_demo/api/getTheaters.php",
        type: "POST",
        success: (response) => {
            response = JSON.parse(response);
            if (response.status) {
                displayTheatersData(response.data);
            } else {
                alert("Failed to fetch theaters data. " + response.message);
            }
        },
        error: () => {
            alert("Error fetching theaters data.");
        },
    });
}
function displayTheatersData(data) {
    const tableBody = $("#theatersTableBody");
    tableBody.empty(); // Clear existing data

    // Add column headers
    const headers = $("<tr>").append(
        $("<th>").text("Theater ID"),
        $("<th>").text("Theater Name"),
        $("<th>").text("Location")
    );
    tableBody.append(headers);

    // Add data rows
    data.forEach((theater) => {
        const row = $("<tr>").append(
            $("<td>").text(theater.theater_id),
            $("<td>").text(theater.theater_name),
            $("<td>").text(theater.location)
        );
        tableBody.append(row);
    });
}
$(document).ready(() => {
   $(".theatre").click(function(){
        showTheatersData();
   })
});
/// displaying data from shows table;


function showShowsData() {
    $.ajax({
        url: "http://localhost/codeschool/php_demo/api/getShows.php",
        type: "POST",
        success: (response) => {
            response = JSON.parse(response);
            if (response.status) {
                displayShowsData(response.data);
            } else {
                alert("Failed to fetch shows data. " + response.message);
            }
        },
        error: () => {
            alert("Error fetching shows data.");
        },
    });
}
function displayShowsData(data) {
    const tableBody = $("#theatersTableBody");
    tableBody.empty(); // Clear existing data

    // Add column headers
    const headers = $("<tr>").append(
        $("<th>").text("Show ID"),
        $("<th>").text("Theater ID"),
        $("<th>").text("Movie Name"),
        $("<th>").text("Show Running")
    );
    tableBody.append(headers);
    data.forEach((show) => {
        const row = $("<tr>").append(
            $("<td>").text(show.show_id),
            $("<td>").text(show.theater_id),
            $("<td>").text(show.movie_name),
            $("<td>").text(show.show_running)
        );
        tableBody.append(row);
    });
}
$(document).ready(()=>{
    $(".showsData").click(function(){
        showShowsData();
    })
});





// for displaying bookings table
function showBookingsData() {
    $.ajax({
        url: "http://localhost/codeschool/php_demo/api/getBookings.php",
        type: "POST",
        success: (response) => {
            response = JSON.parse(response);
            if (response.status) {
                displayBookingsData(response.data);
            } else {
                alert("Failed to fetch bookings data. " + response.message);
            }
        },
        error: () => {
            alert("Error fetching bookings data.");
        },
    });
}
function displayBookingsData(data) {
    const tableBody = $("#theatersTableBody");
    tableBody.empty();
    const headers = $("<tr>").append(
        $("<th>").text("Booking ID"),
        $("<th>").text("Show ID"),
        $("<th>").text("User ID"),
        $("<th>").text("Booked Seats")
    );
    tableBody.append(headers);
    data.forEach((booking) => {
        const row = $("<tr>").append(
            $("<td>").text(booking.booking_id),
            $("<td>").text(booking.show_id),
            $("<td>").text(booking.user_id),
            $("<td>").text(booking.booked_seats)
        );
        tableBody.append(row);
    });
}
$(document).ready(() => {
    $(".bookings").click(function(){
        showBookingsData();
    })
 });

 // add bookings to the taable
 function addBookingData() {
    const showId = prompt("Enter Show ID:");
    const userId = prompt("Enter User ID:");
    const bookedSeats = prompt("Enter Booked Seats:");

    if (showId && userId && bookedSeats) {
        $.ajax({
            url: "http://localhost/codeschool/php_demo/api/addBooking.php",
            type: "POST",
            data: {
                showId,
                userId,
                bookedSeats,
            },
            success: (response) => {
                response = JSON.parse(response);
                if (response.status) {
                    alert("Booking added successfully!");
                } else {
                    alert("Failed to add booking. " + response.message);
                }
            },
            error: () => {
                alert("Error adding booking.");
            },
        });
    }
}

function deleteBookingData() {
    const bookingId = prompt("Enter Booking ID to delete:");

    if (bookingId) {
        $.ajax({
            url: "http://localhost/codeschool/php_demo/api/deleteBooking.php",
            type: "POST",
            data: {
                bookingId,
            },
            success: (response) => {
                response = JSON.parse(response);
                if (response.status) {
                    alert("Booking deleted successfully!");
                } else {
                    alert("Failed to delete booking. " + response.message);
                }
            },
            error: () => {
                alert("Error deleting booking.");
            },
        });
    }
}