
window.addEventListener("message", function(event) {

    var text, type, quantity, type_icon;

    var duration = 5000;
    var containerId = "with-icon";

    if (event.data.type.includes('longer_')) {
        duration = 12000;
        event.data.type = event.data.type.replace('longer_', '');
        containerId = 'no-icon';
    }

    if (event.data.type == 'priority') {
        text = "<priority>" + event.data.text + "</priority>";
    }

    if (event.data.type == 'dev') {
        text = event.data.text;
        type_icon = 'dev';
        containerId = 'no-icon';
    }

    if (event.data.type == 'speech') {
        text = event.data.text;
        containerId = 'no-icon';
    }

    if (event.data.type == 'success') {
        text = event.data.text;
        type_icon = 'success';
        containerId = 'no-icon';
    }

    if (event.data.type == 'error') {
        text = event.data.text;
        type_icon = 'error';
        containerId = 'no-icon';
    }

    if (event.data.type == 'alert') {
        text = event.data.text;
        type_icon = 'alert';
        containerId = 'no-icon';
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

    containerId = '#' + containerId;

    var element = $("<div class='toast'></div>").appendTo(containerId);

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

    if ($(`${containerId} .toast`).length == 1) {
        resetInterval(containerId);
    }
});

let intervalIds = [];

function resetInterval(containerId) {
    if (intervalIds[containerId] != undefined) {
        clearInterval(intervalIds[containerId]);
    }

    $(`${containerId} .toast:first-child()`).animate({
        top: "-=100%",
    }, 150);
    
    console.log($(`${containerId} .toast:first-child()`));

    intervalIds[containerId] = setInterval(function() {

        $(`${containerId} .toast:first-child()`).animate({
            top: "-=100%",
            opacity: "0",
        }, 100, function() {
            $(this).remove();
        });

        $(`${containerId} .toast:nth-child(2)`).animate({
            top: "-=100%",
        }, 150);
    }, 1000);
}

// function fake(text) {
//     // var text = "Você é gay";
//     var quantity = 0;
//     var type = quantity > 0 ? '+' : '-';
//     var quantity = Math.abs(quantity);
//     var type_icon = 'gold';
//     var containerId = '#with-icon';

//     var element = $("<div class='toast'></div>").appendTo(containerId);

//     // $(element).hide();

//     // if (text != undefined) {
//     $(element).append(`<span class='toast-text'>${text}</span>`);
//     // }

//     // if (type != undefined) {
//     // $(element).append(`<span class='toast-type'>${type}</span>`);
//     // }

//     // if (quantity != undefined) {
//     // $(element).append(`<span class='type-quantity'>${quantity}</span>`);
//     // }

//     // if (type_icon != undefined) {
//     $(element).append(`<span class='toast-type-icon'><img src='assets/${type_icon}.png'></span>`);
//     // }

//     if ($(`${containerId} .toast`).length == 1) {
//         resetInterval(containerId);
//     }
// }

// function fake2(text) {
//     // var text = "Você é gay";
//     var quantity = 0;
//     var type = quantity > 0 ? '+' : '-';
//     var quantity = Math.abs(quantity);
//     var type_icon = 'gold';
//     var containerId = '#no-icon';

//     var element = $("<div class='toast'></div>").appendTo(containerId);

//     // $(element).hide();

//     // if (text != undefined) {
//     $(element).append(`<span class='toast-text'>${text}</span>`);
//     // }

//     // if (type != undefined) {
//     // $(element).append(`<span class='toast-type'>${type}</span>`);
//     // }

//     // if (quantity != undefined) {
//     // $(element).append(`<span class='type-quantity'>${quantity}</span>`);
//     // }

//     // if (type_icon != undefined) {
//     $(element).append(`<span class='toast-type-icon'><img src='assets/${type_icon}.png'></span>`);
//     // }

//     if ($(`${containerId} .toast`).length == 1) {
//         resetInterval(containerId);
//     }
// }

// $(document).ready(function() {
//     fake('$ 20.10');
//     fake('Arco');
//     fake('$ 20.10');
//     fake('Arco');
//     fake('$ 20.10');
//     fake('Arco');
//     fake('$ 20.10');
//     fake('Arco');
//     fake2('$ 20.10');
//     fake2('Arco');
//     fake2('$ 20.10');
//     fake2('Arco');
//     fake2('$ 20.10');
//     fake2('Arco');
//     fake2('$ 20.10');
//     fake2('Arco');fake2('$ 20.10');
//     fake2('Arco');
// });