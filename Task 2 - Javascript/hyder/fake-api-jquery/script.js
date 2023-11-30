$(document).ready(function () {
    $.ajax({
        url: 'https://fakestoreapi.com/products',
        method: 'get',
        dataType: 'json',
        data: {
            test: 'test data'
        },
        success: function (results) {
            results.forEach(function (product) {
                //checkbox
                let checkbox = $('<input>').attr('type', 'checkbox');
                //image
                let image = $('<img>').attr('src', product.image).css('width', '20px').css('height', '20px');
                //dollar symbol
                let dollar = $('<span>').text('$').css('color', 'grey').css('font-size', '10px');
                //left stock
                let left = $('<span>').text(' Left').css('color', 'grey').css('font-size', '7px');
                // Generating the star rating
                let star = $('<span>').html('<i class="bi bi-star-fill"></i>').css('color', 'red').css('font-size', '8px').css('text', 'center');
                // random number
                const num = Math.floor(Math.random() * 100);
                //sold stock 
                let sold = $('<p>').text(num + ' sold').css('color', 'grey').css('font-size', '9px');
                let description = $('<p>').text(product.description).css('color', 'grey').css('font-size', '9px');

                //appending data into table body
                $('#store').append(
                    $('<tr>').append(
                        $('<td>').append(checkbox),
                        $('<td>').append(image),
                        $('<td>').append(product.title, description), // Appending title and description
                        $('<td>').append(dollar, product.price), // Appending dollar and price
                        $('<td>').append(product.rating.count, left, sold), // Appending count, left, and sold
                        $('<td>').text(product.category),
                        $('<td>').append(star, product.rating.rate) // Appending star and rating
                    )
                );
            });
        }
    });
});
