var dropdown = document.getElementsByClassName("dropdown-btn");
var i;

function hanburger() {
    var x = document.getElementById("sidenavs");
    var y = document.getElementById("logs");

    if (x.style.display === "none") {
        x.style.display = "block";
        y.style.display === "none"

    } else {
        x.style.display = "none";
        y.style.display === "block";
    }
}

for (i = 0; i < dropdown.length; i++) {
    dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
            dropdownContent.style.display = "none";
        } else {
            dropdownContent.style.display = "block";
        }
    });

}