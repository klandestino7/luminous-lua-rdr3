document.addEventListener('DOMContentLoaded', function() {
    $(".container").hide();
    $("#confirmation-container").hide();
});


let shops = {};

window.addEventListener("message", function(event) {
    var data = event.data;

    if (data.clear == true) {
        $(".slot-container").empty();
    }

    if (data.display == true) {

        if (data.firstTimeData) {

            data.firstTimeData.forEach(function(shopData, index) {
                for (const [shopSubType, shopItemList] of Object.entries(shopData)) {
                    if (shopSubType == "name") {
                        shops[shopItemList] = shopData;
                        break
                    }
                }
            });
        }

        $(".container").show();
        draw(data.shopId);
    }

    if (data.display == false) {
        $(".container").fadeOut(100);
    }
});

function draw(shopId) {

    $('.slot-container').html('');

    var renderedItems = 0;

    for (const [shopSubType, shopItemList] of Object.entries(shops[shopId])) {

        if (shopSubType != "name") {

            for (const [i, itemData] of Object.entries(shopItemList)) {


                var itemId = itemData[0];
                var itemPrice_dollar = itemData[1];
                var itemPrice_gold = itemData[2];
                var itemName = itemData[3];
                var itemWeight = itemData[4];

                itemWeight = itemWeight.toFixed(1);
                itemPrice_dollar = (itemPrice_dollar / 100).toFixed(2);
                itemPrice_gold = (itemPrice_gold / 100).toFixed(2);

                $('.slot-container').append(`
                    <div class="slot" id="${itemId}" onclick="select(this)" ondblclick="buyItem('${shopId}', '${itemId}')">
                        <img src="nui://vp_inventory/nui/images/items/${itemId}.png">
                    </div>
                `);

                var element = $(`.slot-container #${itemId}`);
                $(element).attr('shopId', shopId);
                $(element).attr('name', itemName);
                $(element).attr('weight', itemWeight);
                $(element).attr('p_dollar', itemPrice_dollar);
                $(element).attr('p_gold', itemPrice_gold);

                renderedItems++;
            }
            break;
        }
    }

    if ((renderedItems % 4) != 0) {

        var needed = 0;

        for (i = 0; i < 4; i++) {
            if (((renderedItems + i) % 4) == 0) {
                needed = i;
                break;
            }
        }

        if ((renderedItems + needed) < 16) {
            needed = 16 - renderedItems;
        }

        for (i = 0; i < needed; i++) {
            $('.slot-container').append(`
            <div class="slot">
            </div>
        `);
        }
    }
}

let buyingWithGold = false;

function buy(gold) {
    if ($('.selected').length > 0) {
        var itemName = $('.selected').attr('name');
        $('#confirmation-container').fadeIn(250);
        $('#confirmation-container #confirm_title').text('Vender | ' + itemName);
        buyingWithGold = gold;

        $('#p_gold_img').removeClass('fhover_gold');
        $('#p_dollar_img').removeClass('fhover_dollar');

        if (buyingWithGold) {
            $('#p_gold_img').addClass('fhover_gold');
        } else {
            $('#p_dollar_img').addClass('fhover_dollar');
        }
    }
}

function cancelPurchase() {
    $('#confirmation-container').hide();
    $('#p_gold_img').removeClass('fhover_gold');
    $('#p_dollar_img').removeClass('fhover_dollar');
    buyingWithGold = false;
}

function buyItem() {
    if ($('.selected').length > 0) {
        var shopId = $('.selected').attr('shopId');
        var itemId = $('.selected').attr('id');

        $('#confirmation-container').hide();
        $('#p_gold_img').removeClass('fhover_gold');
        $('#p_dollar_img').removeClass('fhover_dollar');

        $.post('http://vp_shop_sell/buyItem', JSON.stringify({ shopId: shopId, itemId: itemId, withGold: buyingWithGold }));
        buyingWithGold = false;

    }
}
//     $("body").click(function(e) {
//         if (e.target.id == "confirmation-container" || $(e.target).parents("#confirmation-container").length) {} else {
//             if ($('#confirmation-container').is(':visible')) {
//                 $('#confirmation-container').fadeOut(100);
//             }
//         }
//     });
// })


// $(function() {
function select(element) {
    if ($(element).attr('id') != undefined) {
        $('.description-title').text('');
        $('.selected').removeClass('selected');

        $(element).addClass('selected');

        var item_name = $(element).attr('name');
        var item_weight = $(element).attr('weight');
        var item_p_dollar = $(element).attr('p_dollar');
        var item_p_gold = $(element).attr('p_gold');

        $('.description-title').text('Vender | ' + item_name);
        $('#weight').text(item_weight + 'KG');
        $('#p_dollar').text(item_p_dollar);
        $('#p_gold').text(item_p_gold);

        $('#confirmation-container #confirm_title').text(item_name);
    }
}

function unSelect(element) {
    if ($(element).hasClass('selected')) {
        $(element).removeClass('selected');
        $('.description-title').text('');
        $('#confirmation-container').hide();
        buyingWithGold = false;
        $('#p_gold_img').removeClass('fhover_gold');
        $('#p_dollar_img').removeClass('fhover_dollar');
    }
}

function close() {
    $(".container").hide();
    $.post("http://vp_shop_sell/NUIFocusOff", JSON.stringify({}));
}

$(document).keyup(function(e) {
    if (e.key === "Escape") {
        $(".container").fadeOut(100);
        $.post('http://vp_shop_sell/focusOff');
    }
});