
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
    $.post('http://nc_weaponshop/buyItem', JSON.stringify({ itemId: item, zone: zone}));
}


$('.categselect').on('click', function () {
    $('.categselect').removeClass('active')
    $('.categselect').each(function() {
        $("#" + $(this).attr('data-target')).fadeOut(100);
    })

    let t = $("#" + $(this).attr('data-target'))
    $(this).addClass('active');
    t.fadeIn(100);
})




window.addEventListener('message', function (event) {
    var data = event.data;

    console.log(JSON.stringify(data))
        
        // lista.forEach(function(itemList, type){
        //     itemList.forEach(function(itemData, _){
        //         console.log(itemData['imglink'];
        //     });
        // });

    if (data !== undefined) {
        
    $("#all").append(` 
    <div class="item">
        <div class="imagem"><img src="`+data.items.imglink+`"></div>
        <div class="borderl"></div>
        <div class="label">
            <p style="font-size:14px;font-weight:600;text-transform: uppercase;">`+data.items.itemName+`</p>
            <p style="font-size:12px;">Level: `+data.items.level+`</p>
            <p style="font-size:12px;">Preço: `+data.items.money+`$</p>
        </div>
        <div class="borderr"></div>
        <div class="button">
            <button class="buy" onclick="buyItem('`+data.items.itemId+`', '`+data.zone+`')">
                <i class="fas fa-shopping-basket"></i>
            </button>
        </div>
    </div>
    `);

    // $("#weapon").append(` 
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
