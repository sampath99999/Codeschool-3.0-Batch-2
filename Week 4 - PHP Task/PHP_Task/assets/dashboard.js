if (!localStorage.getItem("token")) {
    location.href = "./../dashboard.html";
}

$.ajax({
    url: "http://localhost/PHP_Task/api/getUser.php",
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
    location.href = "./../login.html";
}
$(document).ready(function(){
    $("#button1").click(function(){
        location.href="./products.html";
    })
})
