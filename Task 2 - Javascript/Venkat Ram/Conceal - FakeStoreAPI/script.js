$('document').ready(() => {

    $('#main-btn').click(() => {
        $('#sidebar').toggleClass('hidden')
    })

    $(window).on('resize', function () {
        let windowWidth = $(window).width();
        if (windowWidth < 1499) {
            $('#first-button').addClass('hide');
            $('#first-vr').addClass('hide');
        } else {
            $('#first-button').removeClass('hide');
            $('#first-vr').removeClass('hide');
        }
    });

    $(window).on('resize', function () {
        let windowWidth = $(window).width();
        if (windowWidth < 1366) {
            $('.secondbutton').addClass('second-button');
            $('#second-vr').addClass('hide');
        } else {
            $('.secondbutton').removeClass('second-button');
            $('#second-vr').removeClass('hide');
        }
    });

    $(window).on('resize', function () {
        let windowWidth = $(window).width();
        if (windowWidth < 1350) {
            $('#sidebar').addClass('hidden');
            $('#search-bar').addClass('flexbasis-100');
            $('#search-bar').removeClass('flexbasis-70');
        } else {
            $('#sidebar').removeClass('hidden');
            $('#search-bar').removeClass('flexbasis-100');
            $('#search-bar').addClass('flexbasis-70');
        }
    });

    $(window).on('resize', function () {
        let windowWidth = $(window).width();
        if (windowWidth < 768) {
            $('.finalbutton').addClass('final-button');
            $('.finally').addClass('hide');
            $('.showing-div').addClass('hide');
        } else {
            $('.showing-div').removeClass('hide');
            $('.finalbutton').removeClass('final-button');
            $('.finally').removeClass('hide');
        }
    });

    $(window).on('resize', function () {
        let windowWidth = $(window).width();
        if (windowWidth < 700) {
            $('.finally').addClass('hide');
        } else {
            $('.finally').removeClass('hide');
        }
    });

    $.get('https://fakestoreapi.com/products', (data) => {
        for (let product of data) {

            let tr = document.createElement('tr');
            let image = document.createElement('td');
            image.width = '100';
            let checkbox = document.createElement('td');
            checkbox.width = '5';
            let category = document.createElement('td');
            category.width = '100';
            let title = document.createElement('td');
            title.width = '100';
            let stock = document.createElement('td');
            stock.width = '100';
            let price = document.createElement('td');
            price.width = '100';
            let count = document.createElement('td');
            count.width = '100';
            let rating = document.createElement('td');
            rating.width = '100';

            checkbox.innerHTML = `<span style="text-align: center"><input type="checkbox"></span>`
            rating.innerHTML = `<span><i class="fa-solid fa-star mx-1" style="color: #F26525; font-size: x-small; vertical-align: middle"></i></span>${product.rating.rate} <span style="color: #A8A8A8; font-size: small"> ${product.rating.count} <span>Reviews</span>`;
            title.innerHTML = product.title;
            count.innerHTML = `${Math.floor(Math.random() * 1000) + 1} <span style="color: #A8A8A8; font-size: small">Units</span>`;
            stock.innerHTML = `${Math.floor(Math.random() * 500) + 1} <span style="color: #A8A8A8; font-size: small"> Left <br> ${Math.floor(Math.random() * 500) + 1} Sold</span>`
            price.innerHTML = `$${product.price}`;
            category.innerHTML = `<span class="mx-2" style="height: 5px; width: 5px; background-color: #D8F02B;border-radius: 50%; display: inline-block; vertical-align: middle"></span>${product.category.replace(/(^\w{1})|(\s+\w{1})/g, letter => letter.toUpperCase())}`;

            let img = document.createElement('img');
            img.width = '40';
            img.height = '40';
            img.src = product.image;
            image.appendChild(img);

            tr.appendChild(checkbox);
            tr.appendChild(image);
            tr.appendChild(title);
            tr.appendChild(price);
            tr.appendChild(stock);
            tr.appendChild(count);
            tr.appendChild(category);
            tr.appendChild(rating);
            document.querySelector('tbody').appendChild(tr);
        }
    })
})