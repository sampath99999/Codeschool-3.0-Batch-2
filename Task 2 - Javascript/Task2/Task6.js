const example = fetch("https://fakestoreapi.com/products");
example.then(function (response) {
    response.json().then(function (apiData) {
        // console.log(apiData);
        createTable(apiData);
    });
});
function createTable(data) {
    let tbody = document.querySelector("tbody")
    for (let i = 0; i < data.length; i++) {
        let tRow = document.createElement("tr");
        tRow.setAttribute("scope","row")
        tRow.innerHTML = `
     <td><input type="radio" />    &nbsp;  </td>   
    <td class="p-2"><img src="${data[i].image}" alt="Girl in a jacket" class="img-fluid" width="65px" height="65px"></td>

    <td class=" fw-medium fs-6 p-2">${data[i].title}</td>
    <td class=" fw-medium fs-6 p-2">${data[i].price}</td>

    <td class=" fw-light fs-6 p-2">${data[i].description}</td>
    <td class=" fw-light fs-6 p-2">${data[i].category}</td>


    <td class=" fw-medium fs-6"><i class="fa-solid fa-star" style="color:orange"></i>${data[i].rating.rate}  ${data[i].rating.count} <i class="fa-regular fa-eye"></i></td>
    `;
        tbody.append(tRow);
    }
}

$(document).ready(function () {
    $(".button1").click(function () {
        $("header").toggle();
    });
});
