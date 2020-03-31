window.addEventListener('message', function(event) {
    var data = event.data;

    if (data.clear == true) {
        $(".items").empty();
    }
});

function buyItem(shopId, itemId) {
    $.post('http://vp_shop/buyItem', JSON.stringify({ shopId: shopId, itemId: itemId }));
}

$(document).keyup(function(e) {
    if (e.key === "Escape") {
        $(".container").fadeOut(100);
        $.post('http://vp_shop/focusOff');
    }
});