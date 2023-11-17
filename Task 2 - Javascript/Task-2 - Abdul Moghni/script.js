"use strict";


function renderProducts(items) {
    // looping is
    // for the insertion of product in the html part
    for (let item in items) {
        var product = items[item];
        var Name = product.title;

        var Price = product.price;
        var Rating = product.rating.rate;
        var Volume = product.rating.count;
        var Type = product.category;
        // for creating the random stock and many more
        var Stock = Math.round(Math.random() * 100);
        var Review = Math.round(Math.random() * 50);
        var Image = product.image;

        var Frontend = ` 
        <tr>
                <th scope="row">
                    <div class="form-check col-4 " style="padding-left:25px; display:flex; flex-direction:row;">
                        <input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" >
                        <label class="form-check-label" for="flexCheckChecked">
                      <img id="P-IMAGE" src="${Image}" alt="" style="height:70px;width:70px; >
                      
                    </label>
                        <p id="P-NAME" style="font-size:10px;">${Name}</p>
                        
                    </div>
                </th>
                <td>
                    <p id="P-PRICE">
                        ${Price}
                    </p>
                </td>
                <td>
                    <p id="P-STOCK">${Stock}
                    </p>
                </td>
                <td>
                    <p id="P-VOLUME">${Volume}
                    </p>
                </td>
                <td>
                    <p id="P-TYPE">${Type}
                    </p>
                </td>
                <td>
                    <p id="P-RATING">${Rating}Rating +  ${Review}Review
                    </p>
                </td>

            </tr>
        `;

        $(Frontend).insertAfter(".tbody");
    }
}



const url = `https://fakestoreapi.com/products`;

$(document).ready(function() {
    // API Call when document is loaded
    $.get(url, function(data, status) {
        if (status === "success") {
            renderProducts(data);
            setNotifications();
        }
    });
});