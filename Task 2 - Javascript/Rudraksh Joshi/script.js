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
    const productLeft = Math.round(Math.random() * 300);
    const productSold = Math.round(Math.random() * 100);
    const productReview = Math.round(Math.random() * 50);
    const productImage = product.image;

    // Html to insert
    const html = ` 
        <tr>
        <!-- Product description -->
            <td>
            <div class="d-md-flex align-items-center gap-2 mt-2" >
                <input type="checkbox">
            <!-- Product Image -->
        
                <img class="ms-sm-2 ms-lg-0" src="${productImage}" style="width: 80px;height:80px">
        
                <div >
                 <!-- Product name -->
                    <div class="item-name fw-bold">${productName}</div>
        
                 <!-- Product description -->
                    <div class="itemDescription text-muted">${productDescription}</div>
                </div>
          </div>
            </td>
        <!-- Product Price Details -->
            <td>
                <span style="color:rgb(223, 221, 221)">
                    $
                </span>
                <span class="fw-bold" style="margin-left:-10px">
                   ${productPrice}
                </span>
        
            </td>
        <!-- Product  Stock-->
            <td>
                <!-- Items Remaining -->
                <div class="items-left" style="font-size:14px">
        
                    <span class="fw-bold me-1" >
                        ${productLeft} item
                    </span>  
                    
                    <span class="fw-bold" style="color:rgb(223, 221, 221)">
                        Left
                    </span>
        
                </div>
        
                <!-- Items Sold -->
        
                <div class="items-sold" style="margin-top:-10px;font-size:14px;">
                ${productSold} Sold
                </div>
            </td>
        
        <!-- Volume -->
            <td class="volume">
                <span style="font-size:20px;">${productVolume} quantity</span>
            </td>
        
            <!-- Type -->
            <td class="type" >
                <span style="font-size:20px;">
                    ${productType}
                </span>
            </td>
        
        
        <!-- Rating -->
            <td class='d-flex flex-nowrap  mt-sm-3 mt-4'>
                
                <span>
                    <i class="fa-solid fa-star" style="color: #eea82f"></i>
                </span>
            
                <span class="rating fw-bold me-1">
                    ${productRating}
                </span>
                
                <span class="text-secondary reviews text-nowrap">
               ${productReview} Reviews
                </span>
                
                <span class="position-relative">
                    <i class="bi bi-three-dots-vertical position-absolute"
                    style="right: 0px"></i>
                </span>
            </td>
        </tr>
        <!-- Single product row end -->`;
    $(html).insertAfter(".product-details-container");
  }
}

function setNotifications() {
  const randomNum1 = Math.round(Math.random() * 20);
  const randomNum2 = Math.round(Math.random() * 20);
  $(".notifications").text(randomNum1);
  $(".analytics").text(randomNum2);
}

const url = `https://fakestoreapi.com/products`;

$(document).ready(function () {
  // API Call when document is loaded
  $.get(url, function (data, status) {
    if (status === "success") {
      renderProducts(data);
      setNotifications();
    }
  });
});
