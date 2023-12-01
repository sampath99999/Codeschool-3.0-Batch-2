if (!localStorage.getItem("token")) {
    location.href = "./login.html";
}

$.ajax({
    url: "http://localhost/codeschool/php_demo/api/getUser.php",
    type: "POST",
    data: {
        token: localStorage.getItem("token"),
    },
    success: (response) => {
        console.log(response);
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
