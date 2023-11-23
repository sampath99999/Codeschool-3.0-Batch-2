const url = "https://catfact.ninja/fact"; 

async function getData(api_url) {
    const response = await fetch(api_url); 
    let data = await response.json();
    let fact = data["fact"]
    setTimeout(() => getData(url), 2000)

    document.getElementById("cat_fact").textContent = fact;
}
getData(url);

let insertCard = () => {
    const name = document.querySelector("#name").value;
    const breed = document.querySelector("#breed").value;
    const image_link = document.querySelector("#image_link").value;
    document.querySelector(".insertcard").innerHTML += 
    `<div class="card my-5" style="width: 18rem;">
        <img src="${image_link}" class="card-img-top" alt="" style="height: 11rem; object-fit: contain; margin-top: 10px;">
        <div class="card-body">
            <h5 class="card-title">${name}</h5>
            <p class="card-text">${breed}</p>
        </div>
    </div>`
}
