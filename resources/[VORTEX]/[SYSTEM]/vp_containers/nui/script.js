ItemPool = {}

ItemPoolHash = {}

document.addEventListener("DOMContentLoaded", function(event) {
    // $('body').hide();
    // fakeItemPool();
    // fakeEvent();
    PageFunctionality();

    $(document).keydown(function(event) {
        if (event.which == 27) { // ESC
            $('#inventory').fadeOut();
            // $('#hotbar').fadeOut();
            $('#extra').fadeOut();
            $('#shop').fadeOut();
            $('#crafting').fadeOut();
            $('#trade-player').fadeOut();
            $('#trade-trader').fadeOut();
            $.post("http://vp_containers/focusoff", JSON.stringify({}));
        }
    });
});

window.addEventListener("message", function(event) {
    let rData = event.data;

    if (rData.messageType == "hide") {
        if (rData.container == undefined) {
            $('#inventory').fadeOut();
            $('#hotbar').fadeOut();
            $('#extra').fadeOut();
            $('#shop').fadeOut();
            $('#crafting').fadeOut();
            $('#trade-player').fadeOut();
            $('#trade-trader').fadeOut();
        } else {
            $(`#${rData.container}`).fadeOut();
        }
    }

    if (rData.messageType == "updateItemPool") {
        ItemPool = rData.message;
        ItemPoolHash = rData.message2;
    }

    if (rData.messageType == "drawContainer") {
        let container = rData.container;
        let containerItemPool = rData.containerItemPool;
        let containerNumIndexes = rData.containerNumIndexes;
        let containerActivePage = rData.containerActivePage;
        let containerTitle = rData.containerTitle;
        let containerMaxWeight = rData.containerMaxWeight;
        drawContainer(container, containerItemPool, containerNumIndexes, containerActivePage, containerTitle, containerMaxWeight);
    }
});

function drawContainer(container, containerItemPool, NumSlots, ActivePage, containerTitle, containerMaxWeight) {

    $(`#${container} .slot-container`).html("");
    $(`#${container}`).fadeIn(500);

    // Reseta as classes de tab ativa e seta a nova tab como ativa;
    $(`#${container} header`).text(containerTitle);
    $(`#${container} .page`).removeClass('temp-page-active').removeClass('page-active');
    $(`#${container} .page:nth-child(${ActivePage})`).addClass('page-active');

    let slotContainer_path = `#${container} .slot-container`;
    let FirstActiveSlot = (NumSlots * ActivePage) - (NumSlots - 1);

    for (let slot = FirstActiveSlot; slot < FirstActiveSlot + NumSlots; slot++) {

        // console.log(`${slotContainer_path} .slot:nth-child(${slot - 1})`);
        // let backgroundSlot = $(`${slotContainer_path} .slot:nth-child(${slot - 1})`);

        // if (backgroundSlot != undefined) {
        //     $(backgroundSlot).attr('id', slot);
        //     console.log(backgroundSlot.data('container'));
        //     // console.log('already existed');
        // } else {
        let  backgroundSlot = $(`<div class="slot" id="${slot}" data-container="${container}"></div>`).appendTo(slotContainer_path);
        // }

        let innerSlot = $(`<div class="slot-inner" i></div>`).appendTo(backgroundSlot);

        // innerSlot.append(`<span class="counter">${slot}</span>`);

        // HOT FIX, CONSERTAR OS SLOTS NÃO ESTAREM CORRETOS!!

        let _slot = slot;

        if (container != 'inventory'){
            _slot = _slot - 1;
        }

        if (containerItemPool[_slot] == undefined) {

        } else {

            let receivedData = containerItemPool[_slot];
            let itemHash = receivedData[0];
            let itemAmount = receivedData[1];
            let itemId = ItemPoolHash[itemHash];
            let itemData = ItemPool[itemId];
            let itemType = itemData.type;

            innerSlot.data('itemName', itemData.name);
            innerSlot.data('itemDescription', itemData.desc);

            let display_img = `assets/item_assets/${itemId}.png`;
            let display_counter;

            switch (itemType) {
                case 'generic':
                    display_counter = itemAmount;
                    break;
                case 'weapon':
                    let itemAmmoInClip = receivedData[2];
                    let itemAmmoInWeapon = receivedData[2];
                    display_counter = `${itemAmmoInClip}/${itemAmmoInWeapon}`;
                    break;
                case 'valuable':
                case 'ammo':
                    let itemMaxStackSize = itemData.maxStackSize
                    display_counter = `${itemAmount} de ${itemMaxStackSize}`;
                    break;
            }

            // $(`
            //         <span class="tooltiptext">${itemAmount != null ? "x" + itemAmount + " ": ""}${itemData.name}</span>
            //     `).appendTo(innerSlot);


            if (display_img) {
                innerSlot.append(`<img src="${display_img}">`)
            }
            if (display_counter) {
                // innerSlot.append(`<span class="counter">${display_counter}</span>`);
                innerSlot.data('itemCounter', display_counter);
            }
        }
    }

    // Cria o ultimo slot da hotbar, que não é interagivel!
    if (container == 'hotbar') {
        $(slotContainer_path).append(`
        <div class="slot" id="5" container="hotbar">
                <div class="slot-inner">
                    <img src="assets/item_assets/w_unarmed.png">
                </div>
            </div> 
        `);
    }

    asDroppable();
    asDraggable();
    asHoverable();
    // DEBUG_asHoverable(container);
}

function asDroppable() {
    $(".slot-inner").droppable({
        hoverClass: 'droppable-active',
        addClasses: false,
        drop: function(event, ui) {
            if ($(ui.draggable).data('itemName')) {
                $.post('http://vp_containers/container_dropdraggable', JSON.stringify({
                    container_from: $(ui.draggable).parent().data("container"),
                    container_to: $(this).parent().data("container"),
                    slot_from: $(ui.draggable).parent().attr('id'),
                    slot_to: $(this).parent().attr('id'),
                }));

                $(ui.helper).remove();
            }
        },
    });
}

let carrying = false;

function asDraggable() {
    $(".slot-inner").draggable({
        containment: 'body',
        scroll: false,
        addClasses: false,
        revert: true,
        revertDuration: 200,
        start: function(event, ui) {
            $(ui.helper).css('z-index', '9999');
            $(ui.helper).removeClass('droppable-active');
            carrying = true;
        },
        stop: function(event, ui) {
            carrying = false;
            // $(ui.helper).remove();
        },
    });
}

function asHoverable() {
    $(".slot-inner").mouseenter(function() {
        if (carrying == false) {
            $(this).addClass("droppable-active");
            let containerElement = $(this).parent().parent().parent();
            $(containerElement).find('#hover-title').text($(this).data('itemName'));
            $(containerElement).find('#hover-description').text($(this).data('itemDescription'));
            $(containerElement).find('#hover-counter').text($(this).data('itemCounter'));
        }
    }).mouseleave(function() {
        $(this).removeClass("droppable-active");
        let containerElement = $(this).parent().parent().parent();
        $(containerElement).find('#hover-title').text('');
        $(containerElement).find('#hover-description').text('');
        $(containerElement).find('#hover-counter').text('');
    });
}

function PageFunctionality() {
    $(".page").on('mouseenter', function() {
        $(this).addClass("temp-page-active");
    }).on('mouseleave', function() {
        $(this).removeClass("temp-page-active");
    }).on('click', function() {
        $.post('http://vp_containers/container_changepage', JSON.stringify({
            container: $(this).parent().parent().parent().attr('id'),
            activepage: $(this).index() + 1,
        }));
    });
}

function DEBUG_asHoverable(container) {
    $(`#${container}`).mouseenter(function() {
        $(this).addClass("droppable-active");
    }).mouseleave(function() {
        $(this).removeClass("droppable-active");
    });
}

function fakeEvent() {

    let p = {
        1: [
            15106516, // w_shotgun_doublebarrel
            10, // inClip
            0, // inWeapon
        ],
        2: [
            51515156, // w_lasso
        ],
        3: [
            45465465, // w_molotov
        ],
        4: [
            54648457, // a_shotgun
            10, // itemAmount
        ],
        10: [
            74444466, // gold
            10, // itemAmount
        ],
    }

    var h = {
        1: [
            15106516, // w_shotgun_doublebarrel
            10, // inClip
            0, // inWeapon
        ],
        3: [
            51515156, // w_lasso
        ],
        4: [
            45465465, // w_molotov
        ],
    }

    drawContainer('inventory', p, 9 * 3, 1);
    drawContainer('hotbar', h, 4, 1);
    drawContainer('extra', {}, 9 * 3, 1);
    drawContainer('shop', {}, 3 * 5, 1);
    drawContainer('crafting', {}, 3 * 3, 1);
    drawContainer('trade-player', {}, 4 * 2, 1);
    drawContainer('trade-trader', {}, 4 * 2, 1);

}

function fakeItemPool() {
    ItemPool = {
        "w_shotgun_doublebarrel": {
            type: "weapon",
            name: "Shotgun de cano duplo",
            desc: "Descrição breve.",
            weight: 1.0,
            maxStackSize: 1
        },
        "w_lasso": {
            type: "weapon_melee",
            name: "Lasso",
            desc: "Lorem Ip.",
            weight: 1.0,
            maxStackSize: 1
        },
        "w_molotov": {
            type: "weapon_thrown",
            name: "Molotov",
            desc: "Descrição breve.",
            weight: 1.0,
            maxStackSize: 1
        },
        "a_shotgun": {
            type: "ammo",
            name: "Muniçao de Shotgun",
            desc: "Descrição breve.",
            weight: 1.0,
            maxStackSize: 45
        },
        "dollar": {
            type: "valuable",
            name: "Dollar",
            desc: "Descrição breve.",
            weight: 1.0,
            maxStackSize: 1
        },
        "gold": {
            type: "valuable",
            name: "Ouro",
            desc: "Descrição breve.",
            weight: 1.0,
            maxStackSize: 1
        }
    }

    ItemPoolHash = {
        15106516: "w_shotgun_doublebarrel",
        51515156: "w_lasso",
        45465465: "w_molotov",
        54648457: "a_shotgun",
        48977989: "dollar",
        74444466: "gold",
    }
}