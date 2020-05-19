var ItemPool = [];
var ItemPoolHash = [];

document.addEventListener("DOMContentLoaded", function(event) {
    $('body').hide();
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

        $('body').show();
    }
});

function drawContainer(containerType, containerItemPool) {
    if (containerType == 'inventory') {

        // $('.container-inventory .right .mid').html('');

        // console.log('cleared inventory');

        $.each(containerItemPool, function(slot, v) {
            if (containerItemPool[slot] != null) {
                var itemIdHash = parseInt(v[0]);
                var itemId = ItemPoolHash[itemIdHash];
                var itemType = ItemPool[itemId].type;

                if (itemType == 'weapon') {

                    var weapon_ammoInClip = v[1];
                    var weapon_ammoInWeapon = v[2];

                    // console.log(`[inventory][weapon] Drawing ${itemId} with ${weapon_ammoInClip} in Clip ${weapon_ammoInWeapon} in Weapon`);

                    var html =
                        `
                    <div class="slot">
                        <img src="nui://vp_inventory/nui/images/items/${itemId}.png">
                        <div class="display-ammo">
                            <span>${weapon_ammoInClip}/${weapon_ammoInWeapon}</span>
                            <img/>
                        </div>
                    </div>
                    `;

                    var element = $(html).appendTo('.container-inventory .right .mid');

                    element.data('itemIdHash', itemIdHash);
                    element.data('itemAmount', 1);
                    element.data('weapon_ammoInClip', weapon_ammoInClip);
                    element.data('weapon_ammoInWeapon', weapon_ammoInWeapon);

                    asDraggable(element);
                    asDroppable(element);
                }

                // $(`.container-inventory .right .mid-container .slot:nth-child(${slot - 1})`);
            }
        });

        var numChildren = $('.container-inventory .right .mid').children().length;

        if (numChildren < 128) {
            for (i = numChildren; i < 128; i++) {
                var html =
                    `
                <div class="slot">
                </div>
                `;

                var element = $(html).appendTo('.container-inventory .right .mid');
                asDraggable(element);
                asDroppable(element);
            }
        }

        // $('.container-inventory .right .mid .slot').asDraggable(element);
        // $('.container-inventory .right .mid .slot').asDroppable(element);



        // if (numChildren < 16) {
        //     for (i = numChildren; i < 16; i++) {
        //         var html =
        //             `
        //         <div class="slot">
        //         </div>
        //         `;

        //         $(html).appendTo('.container-inventory .right .mid');
        //     }
        // } else {
        //     if (numChildren % 4 != 0) {
        //         for (i = numChildren; i < 4; i++) {
        //             var html =
        //                 `
        //             <div class="slot">
        //             </div>
        //             `;

        //             $(html).appendTo('.container-inventory .right .mid');
        //             numChildren = numChildren + 1;

        //             if (numChildren % 4 == 0) {
        //                 break;
        //             }
        //         }
        //     }
        // }
    }

    if (containerType == 'hotbar') {

    }
}

function redrawContainerDescription(containerType) {
    if (containerType == 'inventory') {
        if ($('container-inventory').is(':visible')) {

        }
    }
}

// Input
// {itemId, data01, data02, data03, ...}

function redraw(slotId, input) {



}

function asDraggable(element) {
    element.draggable({
        appendTo: 'body',
        scroll: false,
        revert: true,
        revertDuration: 200,
        helper: 'clone',
        zIndex: 99999,
        start: function(event, ui) {

            // ui.helper.css('position', 'absolute');
            // ui.helper.css('font-size', '8px');

            // $(ui.helper).find('.number').remove();
            // $(ui.helper).find('.counter').css('font-size', '8px');
            // $(ui.helper).find('.counter').css('color', 'white');

            // var imgElement = $(ui.helper).find('img')
            // imgElement.css('width', '70px');

            // $(this).draggable('instance').offset.click = {
            //     left: Math.floor(70 / 2),
            //     top: Math.floor(70 / 2)
            // };

            // select($(this));
        },
        stop: function(event, ui) {
            // unSelect($(this));
        },
    });
}

function asDroppable(element) {
    $(element).droppable({
        tolerance: 'pointer',
        hoverClass: 'hovered',
        drop: function(event, ui) {

            var helper = $(ui.helper);
            $(helper).remove();
            var draggable = $(ui.draggable);

            computeOnDrop(element, draggable);
        }
    });
}

function computeOnDrop(droppable, draggable) {

    var droppableContainerType = getContainerTypeFromElement(droppable);
    var draggableContainerType = getContainerTypeFromElement(draggable);

    if (droppableContainerType == "inventory") {

        if (draggableContainerType == "inventory") {

            // $.post('http://vp_inventory2/container_inventory_switch', JSON.stringify({
            //     slotId_1: $(droppable).index(),
            //     slotId_2: $(draggable).index(),
            // }));

            div1 = $(droppable);
            div2 = $(draggable);

            tdiv1 = div1.clone();
            tdiv2 = div2.clone();

            if (!div2.is(':empty')) {
                div1.replaceWith(tdiv2);
                div2.replaceWith(tdiv1);

                asDraggable(tdiv1);
                asDraggable(tdiv2);

                asDroppable(tdiv1);
                asDroppable(tdiv2);
            }
        }
    }

    if (droppableContainerType == 'hotbar') {

        var itemIdHash = $(draggable).data("itemIdHash");
        var itemId = ItemPoolHash[itemIdHash];

        if (draggableContainerType == 'inventory') {
            var itemType = ItemPool[itemId].type;

            if (itemType == 'weapon') {


                // $.post('http://vp_inventory2/container_inventory_switch', JSON.stringify({
                //     slotId_1: $(droppable).index(),
                //     slotId_2: $(draggable).index(),
                // }));

                div1 = $(droppable);
                div2 = $(draggable);

                tdiv1 = div1.clone();
                tdiv2 = div2.clone();

                if (!div2.is(':empty')) {
                    div1.replaceWith(tdiv2);
                    div2.replaceWith(tdiv1);

                    asDraggable(tdiv1);
                    asDraggable(tdiv2);

                    asDroppable(tdiv1);
                    asDroppable(tdiv2);
                }
            }
        }
    }
}

function getContainerTypeFromElement(element) {
    if ($('inventory-container').has(element)) {
        return 'inventory';
    }
}