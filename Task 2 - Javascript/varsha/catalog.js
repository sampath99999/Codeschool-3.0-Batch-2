const example = fetch("https://fakestoreapi.com/products");
example.then(function(response) {
    response.json().then(function(apiData) {

        createTable(apiData);
    });
});

function createTable(data) {
    let body = document.querySelector(".column");
    let table = document.createElement("table");
    table.className = "table"
    table.classList.add = "table-responsive"

    let thead = document.createElement("thead");
    thead.innerHTML = `
      <tr class="fw-bold fs-6">

      <th scope="col">Image</th>

      <th scope="col">title</th>

      <th scope="col">Price</th>
      <th scope="col" class="text-center">Description</th>
      <th scope="col">Category</th>

      <th scope="col">Rating</th>

    </tr>
  `;
    table.append(thead);
    let tbody = document.createElement("tbody");
    for (let i = 0; i < data.length; i++) {
        let tRow = document.createElement("tr");
        tRow.innerHTML = `
    <td><img src="${data[i].image}" alt="Girl in a jacket" width="100px" height="100px"></td>

    <td class=" fw-medium fs-5">${data[i].title}</td>
    <td class=" fw-medium fs-5">${data[i].price}</td>

    <td class=" fw-light fs-5">${data[i].description}</td>
    <td class=" fw-light fs-5">${data[i].category}</td>


    <td class=" fw-medium fs-6"><i class="fa-solid fa-star" style="color:orange"></i>${data[i].rating.rate}  ${data[i].rating.count} <i class="fa-regular fa-eye"></i></td>
    `;
        tbody.append(tRow);
    }
    table.append(tbody);
    body.append(table);
}