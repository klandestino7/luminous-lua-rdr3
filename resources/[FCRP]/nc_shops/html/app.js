window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.clear == true) {
        $(".items").empty();
    }
    if (item.display == true) {
        $(".container").show();
    }
    if (item.display == false) {
        $(".container").fadeOut(100);
    }
});

document.addEventListener('DOMContentLoaded', function () {
    $(".container").hide();
});

function buyItem(item, zone) {
    $.post('http://nc_shops/buyItem', JSON.stringify({ item: item, zone: zone}));
}

window.addEventListener('message', function (event) {
    var data = event.data;

    if (data.price !== undefined) {
    $(".items").append(` 
        <div class="item">
            <img src="`+data.imglink+`">
            <div class="borderl"></div>
            <div class="label">
                <p style="font-size:14px;font-weight:600;text-transform: uppercase;">`+data.itemLabel+`</p>
                <p style="font-size:12px;">Level: `+data.level+`</p>
                <p style="font-size:12px;">Preço: `+data.price+`$</p>
            </div>
            <div class="borderr"></div>
            <div class="button">
                <button class="buy" onclick="buyItem('`+data.item+`', '`+data.zone+`')">
                    <i class="fas fa-shopping-basket"></i>
                </button>
            </div>
        </div>
    `);
    }
});
