"use strict";

// adds products to the page
function renderProducts(items) {
    for (let item in items) {
        const product = items[item];
        const productName = product.title;
        const productDescription = product.description;
        const productPrice = product.price;
        const productRating = product.rating.rate;
        const productVolume = product.rating.count;
        const productType = product.category;

        const productStock = Math.round(Math.random() * 100);
        const productReview = Math.round(Math.random() * 50);
        const productImage = product.image;

        // Html to insert
        const html = ` 
        <tr>
                <th scope="row">
                    <div class="form-check col-4 d-flex flex-column" style="padding-left:25px;">
                        <input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked>
                        <label class="form-check-label" for="flexCheckChecked">
                      <img id="P-IMAGE" src="${productImage}" alt="" style="height:70px;width:70px; >
                      
                    </label>
                        <p id="P-NAME">${productName}</p>
                        
                    </div>
                </th>
                <td>
                    <p id="P-PRICE">
                        ${productPrice}
                    </p>
                </td>
                <td>
                    <p id="P-STOCK">${productStock}
                    </p>
                </td>
                <td>
                    <p id="P-VOLUME">${productVolume}
                    </p>
                </td>
                <td>
                    <p id="P-TYPE">${productType}
                    </p>
                </td>
                <td>
                    <p id="P-RATING">${productRating}Rating +  ${productReview}Review
                    </p>
                </td>

            </tr>
        <!-- Single product row end -->`;
        $(html).insertAfter(".tbody");
    }
}

function setNotifications() {
    const randomNum1 = Math.round(Math.random() * 20);
    const randomNum2 = Math.round(Math.random() * 20);
    $(".notifications").text(randomNum1);
    $(".analytics").text(randomNum2);
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