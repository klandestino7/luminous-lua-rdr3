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

    var element = $(`<div class='toast' data-duration="${duration}"></div>`).appendTo(containerId);

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
        resetInterval(containerId, duration);
    }
});

var intervalIds = [];

function resetInterval(containerId, duration) {
    if (intervalIds[containerId] != undefined) {
        clearInterval(intervalIds[containerId]);
    }

    let elementFirstChild = `${containerId} .toast:first-child()`
    $(elementFirstChild).animate({
        top: "-=100%",
    }, 150);

    intervalIds[containerId] = setInterval(function() {

        let elementSecondChild = `${containerId} .toast:nth-child(2)`;
        let hasNextChild = $(elementSecondChild).length > 0;

        if (hasNextChild) {
            $(elementFirstChild).animate({
                top: "-=100%",
                opacity: "0",
            }, 100, function() {
                $(this).remove();
            });

            $(elementSecondChild).animate({
                top: "-=100%",
            }, 150);

            duration = $(elementSecondChild).data("duration");
        }else{
            $(elementFirstChild).animate({
                opacity: "0",
            }, 100, function() {
                $(this).remove();
            });
        }

    }, duration);
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