window.addEventListener('message', function(event) {
    var data = event.data;

    if (data.clear == true) {
        $(".items").empty();
    }

    if (data.display == true) {

        if (data.firstTimeData) {

            data.firstTimeData.forEach(function(shopData, index) {
                newShopWindow(shopData.name);
                shopData.weapon.forEach(function(shopItemData, index) {
                    newShopItem(shopData.name, 'weapon', shopItemData.itemId, shopItemData.name, shopItemData.level, shopItemData.price);
                });
                shopData.ammo.forEach(function(shopItemData, index) {
                    newShopItem(shopData.name, 'ammo', shopItemData.itemId, shopItemData.name, shopItemData.level, shopItemData.price);
                });
                shopData.melee.forEach(function(shopItemData, index) {
                    newShopItem(shopData.name, 'melee', shopItemData.itemId, shopItemData.name, shopItemData.level, shopItemData.price);
                });
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

function newShopWindow(name) {
    $('.container').append(`
    <div class="shop" id="${name}">
            <p class="title">❯  ${name}</p>
            <div class="menutab">
                <div class="buttonstab">
                    <div class="button active" data-target="all" onclick="tryToChangePage(this)"><span class="helperName"> Todos</span><i class="fas fa-infinity"></i></div>
                    <div class="button" data-target="weapon" onclick="tryToChangePage(this)"><span class="helperName"> Armas</span><i class="fas fa-drumstick-bite"></i></div>
                    <div class="button" data-target="ammo" onclick="tryToChangePage(this)"><span class="helperName"> Munições</span><i class="fas fa-fist-raised"></i></div>
                    <div class="button" data-target="melee" onclick="tryToChangePage(this)"><span class="helperName"> Armas brancas</span><i class="fas fa-screwdriver"></i></div>
                </div>
            </div>

            <div class="items" id="all">
            </div>

            <div class="items" id="weapon" style="display: none;">
            </div>

            <div class="items" id="ammo" style="display: none;">
            </div>

            <div class="items" id="melee" style="display: none;">
            </div>
        </div>
    `);
}

function newShopItem(parentId, itemClass, itemId, name, level, price) {

    $(`#${parentId} #all`).append(`
        <div class="item">
            <img src="nui://fcrp_inventory/html/img/items/${itemId}.png">
            <div class="borderl"></div>
            <div class="label">
                <p>${name}</p>
                <p class="small">NÍVEL ${level}</p>
                <p><i class="fas fa-dollar-sign"></i> ${price},00</p>
            </div>
            <div class="borderr"></div>
            <div class='button-container'>
                <div class="button">
                    <button class="inner" onclick="buyItem('${parentId}', '${itemId}')">
                        <i class="fas fa-shopping-cart"></i>
                    </button>
                </div>
            </div>
        </div>
    `);

    $(`#${parentId} #${itemClass}`).append(`
        <div class="item">
            <img src="nui://fcrp_inventory/html/img/items/${itemId}.png">
            <div class="borderl"></div>
            <div class="label">
                <p>${name}</p>
                <p class="small">NÍVEL ${level}</p>
                <p><i class="fas fa-dollar-sign"></i> ${price},00</p>
            </div>
            <div class="borderr"></div>
            <div class='button-container'>
                <div class="button">
                    <button class="inner" onclick="buyItem('${parentId},' '${itemId}')">
                        <i class="fas fa-shopping-cart"></i>
                    </button>
                </div>
            </div>
        </div>
    `);
}

document.addEventListener('DOMContentLoaded', function() {
    $(".container").hide();
});

function buyItem(shopId, itemId) {
    $.post('http://nc_weaponshop/buyItem', JSON.stringify({ shopId: shopId, itemId: itemId }));
}

// $(".buttonstab").on("click", ".button", function() {
//     tryToChangePage(this);
// });

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
        $.post('http://nc_weaponshop/focusOff');
    }
});