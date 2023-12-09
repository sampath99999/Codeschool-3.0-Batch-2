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
     let role = $('#user_role').find(":selected").val();
     
     
    
 

     $.ajax({
        url: "http://localhost/PHP_Task/api/register.php",
        type: "POST",
        data: {
            name,
            number,
            email,
            password,
            role
            
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




function validate() {
    clearErrors();

    let isValid = true;
    let name = $("#nameInput").val();
    if (name.length < 3 || name.length > 25) {
        $("#nameInput").addClass("is-invalid");
        $("#nameInputError").text("Name should be between 3 and 25 characters");
        isValid = false;
    }
    let email = $("#emailInput").val();
    if (!isValidEmail(email)) {
        $("#emailInput").addClass("is-invalid");
        $("#emailInputError").text("email should be in the form of @gmail.com");
        isValid = false;
    }
    let password = $("#passwordInput").val();
    if (password.length < 6) {
        $("#passwordInput").addClass("is-invalid");
        $("#passwordInputError").text("Password should be at least 6 characters");
        isValid = false;
    }
    let phoneNumber = $("#numberInput").val();
    if (!isValidPhoneNumber(phoneNumber)) {
        $("#numberInput").addClass("is-invalid");
        $("#numberInputError").text("phone number accepts only 10 characters");
        isValid = false;
    }
    let role123 = $("#role").val();
    if (role123 === "") {
        $("#role").addClass("is-invalid");
        $("#roleError").text("Please select a role");
        isValid = false;
    }

    return isValid;
}

function isValidEmail(email) { 
    let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}


function isValidPhoneNumber(phoneNumber) {
    let phoneRegex = /^\d{10}$/;
    return phoneRegex.test(phoneNumber);
}

function clearErrors(){
    $("#nameInput").removeClass("is-invalid");
    $("#emailInput").removeClass("is-invalid");
    $("#passwordInput").removeClass("is-invalid");
    $("#role").removeClass("is-invalid");

    $("#nameInputError").text("");
    $("#emailInputError").text("");
    $("#passwordInputError").text("");
    $("#role").text("");
}   