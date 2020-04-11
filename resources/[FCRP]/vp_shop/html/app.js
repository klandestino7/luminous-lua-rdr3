window.addEventListener('message', function(event) {
    var data = event.data;

    if (data.clear == true) {
        $(".items").empty();
    }

    if (data.display == true) {

        if (data.firstTimeData) {

            data.firstTimeData.forEach(function(shopData, index) {
                newShopWindow(shopData);
            });
        }

        $(".container").show();
        $(".container").children().hide();
        $(`.container #${data.shopId}`).show();
    }

    if (data.display == false) {
        $(".container").fadeOut(100);
    }
});

function newShopWindow(shopData) {


    $('.container').append(`
        <div class="shop" id="${shopData.name}">
            <p class="title">❯  ${shopData.name}</p>
            <div class="menutab">
                <div class="buttonstab">
                    <div class="button active" data-target="all" onclick="tryToChangePage(this)"><span class="helperName"> Todos</span><i class="fas fa-infinity"></i></div>
                </div>
            </div>

            <div class="items" id="all">
            </div>
        </div>
    `);

    for (const [shopSubType, shopItemList] of Object.entries(shopData)) {
        if (shopSubType != 'name') {

            var validSubType = shopSubType.replace(' ', '_');

            if (isNaN(shopSubType) == true) { // If the index is not a number

                $(`#${shopData.name} .menutab .buttonstab`).append(`
                    <div class="button" data-target="${validSubType}" onclick="tryToChangePage(this)">
                        <span class="helperName"> ${shopSubType}</span>
                    </div>
                `);
                $(`#${shopData.name}`).append(`
                    <div class="items" id="${validSubType}" style="display: none;">
                    </div>
                `);
            }

            for (const [index, shopItemData] of Object.entries(shopItemList)) {
                newShopItem(shopData.name, isNaN(shopSubType) == true ? validSubType : 'all', shopItemData, isNaN(shopSubType));
            }
        }
    }
}

function newShopItem(shopId, itemClass, shopItemData, appendToAll) {

    var itemId = shopItemData[0];
    var itemLevel = shopItemData[1];
    var itemPrice = shopItemData[2];
    var itemName = shopItemData[3];

    if (appendToAll == true) {
        $(`#${shopId} #all`).append(`
        <div class="slot">
            <div class="item">
                <div class="column">
                    <div class="information-row">
                        <span class="info-name">${itemName}</span>
                        <span class="info-level">LVL. ${itemLevel}</span>
                    </div>
                    <div class="img-container">
                        <img src="nui://fcrp_inventory/html/img/items/${itemId}.png">
                    </div>
                </div>
                <span class="info-price">${itemPrice} $</span>
            </div>
            <button onclick="buyItem('${shopId}', '${itemId}')">$</button>
            <div class="empty-container"></div>
        </div>
        `);
    }

    $(`#${shopId} #${itemClass}`).append(`
        <div class="slot">
            <div class="item">
                <div class="column">
                    <div class="information-row">
                        <span class="info-name">${itemName}</span>
                        <span class="info-level">LVL. ${itemLevel}</span>
                    </div>
                    <div class="img-container">
                        <img src="nui://fcrp_inventory/html/img/items/${itemId}.png">
                    </div>
                </div>
                <span class="info-price">${itemPrice} $</span>
            </div>
            <button onclick="buyItem('${shopId}', '${itemId}')">$</button>
            <div class="empty-container"></div>
        </div>
    `);
}

document.addEventListener('DOMContentLoaded', function() {
    $(".container").hide();
});

function buyItem(shopId, itemId) {
    console.log(itemId);
    $.post('http://vp_shop/buyItem', JSON.stringify({ shopId: shopId, itemId: itemId }));
}

function tryToChangePage(element) {
    if (!($(element).hasClass("active"))) {

        var shopId = $(element).parent().parent().parent().attr('id');
        var targetPage = $(element).data('target');

        var activeTarget = $(`#${shopId} .buttonstab .active`).data('target');
        $(`#${shopId} #${activeTarget}`).hide();
        $(`#${shopId} .buttonstab .active`).removeClass('active');

        $(element).addClass('active');
        $(`#${shopId} #${targetPage}`).fadeIn(100);
    }
}

$(document).keyup(function(e) {
    if (e.key === "Escape") {
        $(".container").fadeOut(100);
        $.post('http://vp_shop/focusOff');
    }
});