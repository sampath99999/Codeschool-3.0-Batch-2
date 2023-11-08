function bodyload() {
    fetch("https://fakestoreapi.com/products/")
      .then(function (response) {
        return response.json();
      })
      .then(function (data) {
        for (var item of data) {
          var tr = document.createElement("tr");
          var tdImage = document.createElement("td");
          var tdCategory = document.createElement("td");
          var tdTitle = document.createElement("td");
          var tdPrice = document.createElement("td");
          var tdDescription = document.createElement("td");
          var tdRating = document.createElement("td");

          tdRating.innerHTML = `<span class="glyphicon glyphicon-star text-danger"></span>${item.rating.rate} ${item.rating.count}`;
          tdTitle.innerHTML = item.title;
          tdPrice.innerHTML = item.price;
          tdDescription.innerHTML = item.description;
          tdCategory.innerHTML = item.category;

          var img = document.createElement("img");
          img.width = "50";
          img.height = "50";
          img.src = item.image;
          tdImage.appendChild(img);

          tr.appendChild(tdImage);
          tr.appendChild(tdCategory);
          tr.appendChild(tdTitle);
          tr.appendChild(tdPrice);
          tr.appendChild(tdDescription);
          tr.appendChild(tdRating);
          document.querySelector("tbody").appendChild(tr);
        }
      })

      
      $(".sidebar ul li").on('click', function () {
        $(".sidebar ul li.active").removeClass('active');
        $(this).addClass('active');
    });

        $('.open-btn').on('click', function () {
        $('.sidebar').addClass('active');
    });

        $('.close-btn').on('click', function () {
        $('.sidebar').removeClass('active');
    })
  }