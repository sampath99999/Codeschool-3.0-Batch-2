if (localStorage.getItem("token")){
    location.href="./../dashboard.html";
}


function register(event){
     event.preventDefault();
     if(!validate()){
        return false;
     }
     let name = $("#nameInput").val();
     let email = $("#emailInput").val();
     let password = $("#passwordInput").val();
     let number = $("#numberInput").val();

     $.ajax({
        url: "http://localhost/PHP_Task/api/register.php",
        type: "POST",
        data: {
            name,
            number,
            email,
            password
            
        },
        datatype: "JSON",
        success: (response) =>{
            if (!response.status){
                swal.fire(
                    "Registration Unsuccessful",response.message,"error"
                );
                return false;
            }
            location.href="./../login.html";
        },
        error:(response) =>{
            console.log("Error: " + response);
        },
     });
}


function validate(){
    clearErrors();

    let name = $("#nameInput").val();
    let number = $("#numberInput").val();
    let email = $("#emailInput").val();
    let password = $("#passwordInput").val();
    

    if (name.length < 3 || name.length > 25){
        $("#nameInput").addClass("is-invalid");
        $("#nameInputError").text(
            "Name should be at least 3 characters or at most 25 characters"
        );
        return false;
    }
    return true;
}

function clearErrors(){
    $("#nameInput").removeClass("is-invalid");
    $("#emailInput").removeClass("is-invalid");
    $("#passwordInput").removeClass("is-ivalid");

    $("#nameInputError").text("");
    $("#emailInputError").text("");
    $("#passwordInputError").text("");
}