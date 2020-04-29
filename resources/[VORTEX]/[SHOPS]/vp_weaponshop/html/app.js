$(".container").hide(0);

window.addEventListener('message', function(event) {
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

document.addEventListener('DOMContentLoaded', function() {
    $(".container").hide();
});


function buyItem(item, money, gold) {
    if (money != undefined){
        $.post('http://vp_weaponshop/buyItem', JSON.stringify({ itemId: item, money: money}));
    }
    if (gold != undefined){
        $.post('http://vp_weaponshop/buyItem', JSON.stringify({ itemId: item, gold: gold}));
    }
}


$('.categselect').on('click', function() {
    $('.categselect').removeClass('active')
    $('.categselect').each(function() {
        $("#" + $(this).attr('data-target')).fadeOut(100);
    })

    let t = $("#" + $(this).attr('data-target'))
    $(this).addClass('active');
    t.fadeIn(100);
})

window.addEventListener('message', function(event) {
    var data = event.data;

    // lista.forEach(function(itemList, type){
    //     itemList.forEach(function(itemData, _){
    //         console.log(itemData['imglink'];
    //     });
    // });

    if (data !== undefined) {

    $("#all").append(` 
    <div class="item">
        <div class="imagem"><img src="` + data.items.imglink + `"></div>
        <div class="borderl"></div>
        <div class="label">
            <p style="font-size:13px;font-family: 'robotoslab';font-weight:600;text-transform: uppercase;">` + data.items.itemName + `</p>
            <p style="font-size:12px;">Lvl: ` + data.items.level + `</p>
        </div>
        <div class="borderr"></div>
        <div class="buttonb">
            <button class="dollar" onclick="buyItem('` + data.items.itemId + `', '` + data.items.money + `', '` + undefined + `')">
            <span style="color:#9e9e9e">` + data.items.money + `$</span>
            </button>
            <button class="gold" onclick="buyItem('` + data.items.itemId + `', '` + undefined + `', '` + data.items.gold + `')">
            <span style="color:#e0a604">G` + data.items.gold + `</span>
            </button>
        </div>
    </div>
    `);

    // $("#all").append(` 
    // <div class="item">
    //     <div class="imagem"><img src="` + data.items.imglink + `"></div>
    //     <div class="borderl"></div>
    //     <div class="label">
    //         <p style="font-size:13px;font-family: 'robotoslab';font-weight:600;text-transform: uppercase;">` + data.items.itemName + `</p>
    //         <p style="font-size:12px;">Lvl: ` + data.items.level + `</p>
    //         <p style="font-size:13px; font-weight:600"><span style="color:#9e9e9e">` + data.items.money + `$</span> | <span style="color:#e0a604">G` + data.items.gold + `</span></p>
    //     </div>
    //     <div class="borderr"></div>
    //     <div class="buttonb">
    //         <button class="dollar" onclick="buyItem('` + data.items.itemId + `', '` + data.items.amount + `', '` + data.items.money + `', '0')">
    //         <span style="color:#9e9e9e">` + data.items.money + `$</span>
    //         </button>
    //         <button class="gold" onclick="buyItem('` + data.items.itemId + `', '` + data.items.amount + `', '0', '` + data.items.gold + `')">
    //         <span style="color:#e0a604">G` + data.items.gold + `</span>
    //         </button>
    //     </div>
    // </div>
    // `);

        // $("#ammo").append(` 
        // <div class="item">
        //     <img src="`+data.imglink+`">
        //     <div class="borderl"></div>
        //     <div class="label">
        //         <p style="font-size:14px;font-weight:600;text-transform: uppercase;">`+data.itemName+`</p>
        //         <p style="font-size:12px;">Level: `+data.level+`</p>
        //         <p style="font-size:12px;">Preço: `+data.money+`$</p>
        //     </div>
        //     <div class="borderr"></div>
        //     <div class="button">
        //         <button class="buy" onclick="buyItem('`+data.item+`', '`+data.zone+`')">
        //             <i class="fas fa-shopping-basket"></i>
        //         </button>
        //     </div>
        // </div>
        // `);

        // $("#melee").append(` 
        // <div class="item">
        //     <img src="`+data.imglink+`">
        //     <div class="borderl"></div>
        //     <div class="label">
        //         <p style="font-size:14px;font-weight:600;text-transform: uppercase;">`+data.itemName+`</p>
        //         <p style="font-size:12px;">Level: `+data.level+`</p>
        //         <p style="font-size:12px;">Preço: `+data.money+`$</p>
        //     </div>
        //     <div class="borderr"></div>
        //     <div class="button">
        //         <button class="buy" onclick="buyItem('`+data.item+`', '`+data.zone+`')">
        //             <i class="fas fa-shopping-basket"></i>
        //         </button>
        //     </div>
        // </div>
        // `);
    }
});
