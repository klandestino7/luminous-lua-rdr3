window.addEventListener("message", function(event) {

    var text, type, quantity, type_icon;

    var duration = 5000;

    if (event.data.type.includes('longer_')) {
        duration = 12000;
        event.data.type = event.data.type.replace('longer_', '');
    }

    if (event.data.type == 'priority') {
        text = "<priority>" + event.data.text + "</priority>";
    }

    if (event.data.type == 'dev') {
        text = event.data.text;
        type_icon = 'dev';
    }

    if (event.data.type == 'speech') {
        text = event.data.text;
    }

    if (event.data.type == 'success') {
        text = event.data.text;
        type_icon = 'success';
    }

    if (event.data.type == 'error') {
        text = event.data.text;
        type_icon = 'error';
    }

    if (event.data.type == 'alert') {
        text = event.data.text;
        type_icon = 'alert';
    }

    if (event.data.type == 'item') {
        text = event.data.text;
        quantity = event.data.quantity;
        type = quantity > 0 ? '+' : '-';
        quantity = Math.abs(quantity);
        type_icon = 'item';
    }

    if (event.data.type == 'dollar') {
        quantity = event.data.quantity;
        type = quantity > 0 ? '+' : '-';
        quantity = Math.abs(quantity);
        type_icon = 'dollar';
    }

    if (event.data.type == 'gold') {
        quantity = event.data.quantity;
        type = quantity > 0 ? '+' : '-';
        quantity = Math.abs(quantity);
        type_icon = 'gold';
    }

    var element = $("<div class='toast'></div>").appendTo('.toast-container');

    $(element).hide();


    if (event.data.type == 'speech') {
        $(element).addClass('background');
    }

    if (text != undefined) {
        $(element).append(`<span class='toast-text'>${text}</span>`);
    }

    if (type != undefined) {
        $(element).append(`<span class='toast-type'>${type}</span>`);
    }

    if (quantity != undefined) {
        $(element).append(`<span class='type-quantity'>${quantity}</span>`);
    }

    if (type_icon != undefined) {
        $(element).append(`<span class='toast-type-icon'><img src='assets/${type_icon}.png'></span>`);
    }

    $(element).fadeIn(1000);

    //$(element).addClass('end').delay(8000);

    setTimeout(function() {
        $(element).addClass('outro');
        setTimeout(function() {
            $(element).remove();
        }, 1000);
    }, duration);

    //  $(element).fadeIn(1000).delay(8000).fadeOut(1000);
});