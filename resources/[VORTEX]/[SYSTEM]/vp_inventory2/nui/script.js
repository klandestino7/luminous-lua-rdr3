var ItemPool = [];
var ItemPoolHash = [];

var actionPressed = "NONE";

var container_options = {
    "inventory": {
        "visibility": 1
    },
    "hotbar": {
        "visibility": 1
    },
}

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
        name: "Shotgun de cano duplo",
        desc: "Descrição breve.",
        weight: 1.0,
        maxStackSize: 1
    },
    "w_molotov": {
        type: "weapon_thrown",
        name: "Shotgun de cano duplo",
        desc: "Descrição breve.",
        weight: 1.0,
        maxStackSize: 1
    },
    "a_shotgun": {
        type: "ammo",
        name: "Muniçao de Shotgun",
        desc: "Descrição breve.",
        weight: 1.0,
        maxStackSize: 1
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

document.addEventListener("DOMContentLoaded", function(event) {
    $('container-inventory').hide();
    $('container-hotbar').hide();
    $('body').hide();

    p = {
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
        5: [
            74444466, // gold
            10, // itemAmount
        ],
    }

    drawContainer('inventory', p);
    drawContainer('hotbar', {});
});

window.addEventListener("message", function(event) {
    let rData = event.data;

    if (rData.messageType == "hide") {
        $('body').hide();
    }

    if (rData.messageType == "updateItemPool") {
        ItemPool = rData.message;
        ItemPoolHash = rData.message2;
    }

    if (rData.messageType == "drawContainer") {
        var containerType = rData.message;
        var containerItemPool = rData.message2;
        drawContainer(containerType, containerItemPool);
    }
});

function drawContainer(containerType, containerItemPool) {
    $('body').show();

    if (containerType == 'inventory') {

        // $('.container-inventory .right .mid').html('');

        // console.log('cleared inventory');

        var pathAppendTo = ".container-inventory .right .mid";

        $('.container-inventory').fadeIn();

        for (i = 1; i < 129; i++) {


            var parentElement = $(`<div class="slot" id="${i}"></div>`).appendTo(pathAppendTo);

            if (containerItemPool[i] != null) {

                var html = "";

                var atSlot = containerItemPool[i];

                var itemIdHash = parseInt(atSlot[0]);

                var itemId = ItemPoolHash[itemIdHash];
                var itemType = ItemPool[itemId].type;

                if (itemType == 'weapon') {

                    var weapon_ammoInClip = atSlot[1];
                    var weapon_ammoInWeapon = atSlot[2];

                    // console.log(`[inventory][weapon] Drawing ${itemId} with ${weapon_ammoInClip} in Clip ${weapon_ammoInWeapon} in Weapon`);

                    html =
                        `
                        <div class="inner-slot">
                            <img src="${getIMGPath(itemId)}">
                            <div class="display-ammo">
                                <span>${weapon_ammoInClip}/${weapon_ammoInWeapon}</span>
                                <img/>
                            </div>
                        </div>
                    `;

                    var element = $(html).appendTo(parentElement);


                    element.data('itemAmount', 1);
                    element.data('weapon_ammoInClip', weapon_ammoInClip);
                    element.data('weapon_ammoInWeapon', weapon_ammoInWeapon);

                } else if (itemType == 'weapon_melee' || itemType == 'weapon_thrown') {
                    html =
                        `
                        <div class="inner-slot">
                            <img src="${getIMGPath(itemId)}">
                        </div>
                    `;

                    var element = $(html).appendTo(parentElement);

                    element.data('itemAmount', 1);
                } else if (itemType == 'ammo') {

                    var itemAmount = atSlot[1];

                    html =
                        `
                        <div class="inner-slot">
                            <img src="${getIMGPath(itemId)}">
                            ${itemAmount}
                        </div>
                    `;

                    var element = $(html).appendTo(parentElement);

                    element.data('itemAmount', itemAmount);
                } else {
                    var itemAmount = atSlot[1];

                    html =
                        `
                        <div class="inner-slot">
                            <img src="${getIMGPath(itemId)}">
                            ${itemAmount}
                        </div>
                    `;

                    var element = $(html).appendTo(parentElement);

                    element.data('itemAmount', itemAmount);
                }

                element.data('itemIdHash', itemIdHash);

                // $(`.container-inventory .right .mid-container .slot:nth-child(${slot - 1})`);
            }

        }

        asSwappable_container_inventory();
    }

    if (containerType == 'hotbar') {

        var pathAppendTo = ".container-hotbar";

        $('.container-hotbar').fadeIn();

        for (i = 1; i < 6; i++) {

            var parentElement = $(`<div class="slot" id="${i}"></div>`).appendTo(pathAppendTo);

            if (containerItemPool[i] != null) {

                var html = "";

                var atSlot = containerItemPool[i];

                var itemIdHash = parseInt(atSlot[0]);


                var itemId = ItemPoolHash[itemIdHash];
                var itemType = ItemPool[itemId].type;

                if (itemType == 'weapon') {

                    var weapon_ammoInClip = atSlot[1];
                    var weapon_ammoInWeapon = atSlot[2];

                    // console.log(`[inventory][weapon] Drawing ${itemId} with ${weapon_ammoInClip} in Clip ${weapon_ammoInWeapon} in Weapon`);

                    html =
                        `
                        <div class="inner-slot">
                            <img src="${getIMGPath(itemId)}">
                            <div class="display-ammo">
                                <span>${weapon_ammoInClip}/${weapon_ammoInWeapon}</span>
                                <img/>
                            </div>
                        </div>
                    `;

                    var element = $(html).appendTo(parentElement);


                    element.data('itemAmount', 1);
                    element.data('weapon_ammoInClip', weapon_ammoInClip);
                    element.data('weapon_ammoInWeapon', weapon_ammoInWeapon);

                } else if (itemType == 'weapon_melee' || itemType == 'weapon_thrown') {
                    html =
                        `
                        <div class="inner-slot">
                            <img src="${getIMGPath(itemId)}">
                        </div>
                    `;

                    var element = $(html).appendTo(parentElement);

                    element.data('itemAmount', 1);
                } else if (itemType == 'ammo') {

                    var itemAmount = atSlot[1];

                    html =
                        `
                        <div class="inner-slot">
                            <img src="${getIMGPath(itemId)}">
                            ${itemAmount}
                        </div>
                    `;

                    var element = $(html).appendTo(parentElement);

                    element.data('itemAmount', itemAmount);
                }

                element.data('itemIdHash', itemIdHash);
            }
        }

        asSwappable_container_hotbar();
    }

    ContainerOptionVisibility(containerType, container_options[containerType].visibility);
}

function computeSwap(inner_slot_from, inner_slot_to) {


    var containerType_from = getContainerTypeFromElement(inner_slot_from);
    var containerType_to = getContainerTypeFromElement(inner_slot_to);

    var itemIdHash_from = $(inner_slot_from).data("itemIdHash");
    var itemIdHash_to = $(inner_slot_to).data("itemIdHash");

    var itemType_from = getItemTypeFromItemIdHash(itemIdHash_from);
    var itemType_to = getItemTypeFromItemIdHash(itemIdHash_to);

    var is_from_null = (itemType_from == null);
    var is_to_null = (itemIdHash_to == null);

    // Tá dropando um slot no inventario
    if (containerType_to == 'inventory') {

        if (containerType_from == 'inventory') {

            if (actionPressed == 'NONE') {

            }

        } else if (containerType_from == 'hotbar') {
            // Enviar pro client remover arma
        }

        // Tá dropando um slot na hotbar
    } else if (containerType_to == 'hotbar') {
        // Enviar para o client e atualizar armas
    }
}

function swap(element_1, element_2) {

}

function redrawContainerDescription(containerType) {
    if (containerType == 'inventory') {
        if ($('container-inventory').is(':visible')) {

        }
    }
}

function asDroppable(selector) {
    $(selector + " .slot").droppable({
        // hoverClass: 'droppable-hovered',
        activeClass: 'droppable-active',
        accept: '.inner-slot',
        addClasses: false,
        // drop: computeSwap()
    });
}

function asDraggable(selector) {
    $(selector + " .inner-slot").draggable({
        containment: 'body',
        hoverClass: 'droppable-hovered',
        accept: '.inner-slot',
        scroll: false,
        addClasse: false,
        revert: true,
        start: function(event, ui) {
            $(ui.helper).css('z-index', '9999');
        }
    });
}

function asSwappable_container_inventory() {
    var selector = ".container-inventory .right .mid"

    asDroppable(selector);
    asDraggable(selector);
}

function asSwappable_container_hotbar() {

    var selector = ".container-hotbar";

    asDroppable(selector);
    asDraggable(selector);

    // Hotbar slot #1 e #2 só vai aceitar items do tipo weapon

    $('.container-hotbar #1, #2').droppable("option", "accept", function(d) {

        if (getContainerTypeFromElement(d) == 'inventory' || getContainerTypeFromElement(d) == 'hotbar') {
            var itemIdHash = d.data("itemIdHash");
            var itemType = getItemTypeFromItemIdHash(itemIdHash);

            if (itemType == "weapon") {
                return true
            }
        }

        return false;
    });

    $('.container-hotbar #3, #4').droppable("option", "accept", function(d) {

        if (getContainerTypeFromElement(d) == 'inventory' || getContainerTypeFromElement(d) == 'hotbar') {
            var itemIdHash = d.data("itemIdHash");
            var itemType = getItemTypeFromItemIdHash(itemIdHash);


            if (itemType == "weapon_thrown" || itemType == 'weapon_melee') {
                return true
            }
        }

        return false;
    });

    $('.container-hotbar #5').droppable("destroy");

}

function getIMGPath(itemId) {
    // console.log('assets/item_assets/' + itemId + '.png')
    return 'assets/item_assets/' + itemId + '.png';
}

function getContainerTypeFromElement(element) {
    // console.log(element);
    if ($(element).closest(".container-inventory").length > 0) {
        return 'inventory';
    } else if ($(element).closest(".container-hotbar").length > 0) {
        return 'hotbar';
    }
    return 'none';
}

function getItemTypeFromItemIdHash(itemIdHash) {

    if (ItemPoolHash[itemIdHash]) {
        return ItemPool[ItemPoolHash[itemIdHash]].type;
    }
    return null;
}

function ContainerOptionVisibility(containerType, visibility) {
    if (containerType == 'inventory') {

        container_options[containerType].visibility = visibility;

        var first_slot = (visibility * 20) - 19
        var last_slot = (visibility * 20)

        $('.container-inventory .mid .slot').filter(function(index) {
            var slotId = parseInt($(this).attr('id'));
            return (slotId >= first_slot && slotId <= last_slot)
        }).show();

        $('.container-inventory .mid .slot').filter(function(index) {
            var slotId = parseInt($(this).attr('id'));
            return (slotId < first_slot || slotId > last_slot)
        }).hide();
    }
}

$(document).ready(function() {

    $(document).keyup(function(event) {
        if (event.which == shortcutPressed) {
            actionPressed = "NONE";
        }
    });

    $(document).keydown(function(event) {
        if (event.which == 16) { // L-SHIFT
            actionPressed = 'HALF'
        }

        if (event.which == 17) { // L-CTRL
            actionPressed = 'SINGLE'
        }
    });
});